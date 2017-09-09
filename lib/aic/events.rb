
class Aic::Event # HAS ONE EventType
  attr_accessor :title, :type, :date, :time, :url, :description
  @@all = [] #array with all events
  @@counter = 0

  def self.scrape_from_web(url) #creates Event objects from URL
    doc = Nokogiri::HTML(open("#{url}"))
    event_array = doc.css("div.calendar_result div.views-row")
    event_array.each do |xml_element| #try to refactor with send
      new_event = Aic::Event.new
      new_event.title = xml_element.css("div.col-wrapper.clearfix div.col-inner div.title.views-field.views-field-title").text.strip
      new_event.type = Aic::EventType.new(xml_element.css("div.col-wrapper.clearfix div.col-inner div.views-field.views-field-taxonomy").text.strip) #should hook into EventType
      #need to create a new EventType object
      new_event.date = Chronic.parse(xml_element.css("div.col-wrapper.clearfix div.col-inner div.date.views-field").text.strip)
      new_event.description = xml_element.css("div.col-wrapper.clearfix div.col-inner div.summary.views-field p").text.strip
      new_event.url = "http://www.artic.edu" + xml_element.css("div.col-wrapper.clearfix div.col-inner div.title.views-field.views-field-title a").attribute("href").text.strip
      new_event.time = xml_element.css("div.col-wrapper.clearfix div.col-inner div.time.views-field").text.strip
      @@all << new_event
    end
  end #scraper

  def self.all
    @@all
  end

  def self.type_or_next #determines if user stays in Events or goes to EventTypes
    first_input = gets.strip
    case first_input
    when "type"
      Aic::EventType.select_type
      #Aic::EventType.event_list
    when "next"
      event_menu
    end #case statment
  end #type_or_next

######FIX THIS TO RETURN LIST OF UNIQUE EVENTS####
  def self.event_menu #returns list of UNIQUE
    #needs to be refactored so that each event is only included once on the list if it is a repeat
    current_hash = Hash.new(v=[])
    @@all.each.with_index(1) {|e, i| current_hash[i] =  ["#{e.title}", "#{e.type.name}"]}
    unique_hash = {}
    unique_array = @@all.uniq {|e| e.title}
    unique_array.each.with_index(1) {|e,i| unique_hash[i] = e}
    if unique_array.size >= 20
      nested_arrays = unique_hash.to_a.each_slice(20).to_a
        if @@counter <= nested_arrays.size
          nested_arrays[@@counter].each  {|nest| puts "#{nest[0]}. #{nest[1].title} (#{nest[1].type.name})"}
          end #@@counter if
    else
      unique_array.each.with_index(1) {|n, i| puts "#{i}. #{n.title} (#{n.type.name})"}
    end #unique_array.size
    puts "Enter an event name or number for dates, times, and description."
    puts "Or enter 'more' to see the next 20 events."
    input_1 = gets.strip

    if (input_1.to_i.is_a?(Integer)) && (unique_hash.detect {|k,v| k == "#{input_1}".to_i})
    #if unique_hash.detect {|k,v| v.title.include?("#{input_1}") || k == "#{input_1}".to_i}
    #binding.pry
      sleep(0.5)
      self.event_info(unique_hash, current_hash, input_1)
    elsif !input_1.to_i.is_a?(Integer) && unique_hash.detect {|k,v| v.title.include?("#{input_1}")}
      sleep(0.5)
      self.event_info(unique_hash, current_hash, input_1)
    elsif input_1 == "more" #working
      sleep(0.5)
      @@counter += 1
      event_menu
    elsif unique_hash.none? {|k,v| v.title.include?("#{input_1}") || k == "#{input_1}".to_i}
       sleep(0.5) #working
       puts "Sorry! I can't find that event."
       event_menu
     end #outer if statement
  end #event_menu

  def self.event_info(unique_hash, all_hash, ip)

    sleep(0.5) #input is either event title or number
    y = unique_hash.detect {|k,v| v == "#{ip}" || k == "#{ip}".to_i}[1].title

    if all_hash.detect {|k,v|  v[0] == "#{y}"}

      found_events = [] #array of all events fitting input
        z = all_hash.select {|k,v|  v[1] == "#{y}"}
binding.pry
        z.each {|k,v| found_events << v}
        puts "#{found_events[0].title}"
        puts "#{found_events[0].type.name}"
        puts "#{found_events[0].description}"
        puts "When:"
        found_events.each do |e|
          puts "#{e.date.strftime("%m-%d-%Y")}"
          puts "#{e.time}"
          puts "#{e.url}"
          puts ""
        end #found_events
      elsif all_hash.none? {|k,v| v == "#{y}"}
        sleep(0.5)
        puts "Sorry! I can't find that event."
        event_menu
    end #if statement
    #occurs = []
    #@@all.each do |event|
    #  if event.title.include? (event_hash.detect {|k,v| v.include?("#{input}") || k == "#{input}".to_i}[1][0])
    #    occurs << event
    #  end #if statement
    #  binding.pry
    #end # all each end
    #occurs
    #  puts "#{occurs[0].title}"
    #  puts "#{occurs[0].type.name}"
    #  puts "#{occurs[0].description}"
    #  puts "When:"
    #occurs.each do |e|
    #  puts "#{e.date.strftime("%m-%d-%Y")}"
    #  puts "#{e.time}"
    #  puts "#{e.url}"
    #  puts ""
    #end #occurs each
  end #event_info


end
