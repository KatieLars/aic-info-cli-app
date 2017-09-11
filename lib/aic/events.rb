
class Aic::Event # HAS ONE EventType
  attr_accessor :title, :type, :date, :time, :url, :description
  @@all = [] #array with all events
  @@counter = 0

  def self.scrape_from_web(url) #creates Event objects from URL
    doc = Nokogiri::HTML(open("#{url}"))
    event_array = doc.css("div.calendar_result div.views-row")
    new_event = Aic::Event.new
    event_array.each do |xml_element|

      new_event.title = xml_element.css("div.col-wrapper.clearfix div.col-inner div.title.views-field.views-field-title").text.strip
      new_event.type = Aic::EventType.new(xml_element.css("div.col-wrapper.clearfix div.col-inner div.views-field.views-field-taxonomy").text.strip)
      new_event.date = Chronic.parse(xml_element.css("div.col-wrapper.clearfix div.col-inner div.date.views-field").text.strip)
      new_event.description = xml_element.css("div.col-wrapper.clearfix div.col-inner div.summary.views-field p").text.strip
      new_event.url = "http://www.artic.edu" + xml_element.css("div.col-wrapper.clearfix div.col-inner div.title.views-field.views-field-title a").attribute("href").text.strip
      new_event.time = xml_element.css("div.col-wrapper.clearfix div.col-inner div.time.views-field").text.strip
      @@all << new_event
    end
    binding.pry
    @@all
    new_event.type.add_events
  end #scraper

  def self.all
    @@all
  end

  def self.type_or_next #determines if user stays in Events or goes to EventTypes
    first_input = gets.strip
    case first_input
    when "type"
      Aic::EventType.select_type
    when "next"
      event_menu
    end #case statment
    binding.pry
  end #type_or_next

  def self.event_menu
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
    if (input_1.to_i != 0) && (unique_hash.detect {|k,v| k == "#{input_1}".to_i})
      sleep(0.5)
      self.event_info(unique_hash, current_hash, input_1)
    elsif (input_1.to_i == 0) && (unique_hash.detect {|k,v| v.title.include?("#{input_1}")})
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
    sleep(0.5)
    y = unique_hash.detect {|k,v| v.title.include? "#{ip}" || k == "#{ip}".to_i}[1].title
      if all_hash.detect {|k,v|  v[0] == "#{y}"}
        z = @@all.select {|e| e.title == "#{y}"}
        puts "#{z[0].title}"
        puts "#{z[0].type.name}"
        puts "#{z[0].description}"
        puts "When:"
        z.each do |e|
          puts "#{e.date.strftime("%m-%d-%Y")}"
          puts "#{e.time}"
          puts "#{e.url}"
          puts ""
        end
      elsif all_hash.none? {|k,v| v == "#{y}"}
        sleep(0.5)
        puts "Sorry! I can't find that event."
        event_menu
      end #if statement
  end #event_info


end
