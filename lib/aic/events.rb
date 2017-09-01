
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

  def self.event_menu
    sleep(0.5)
    puts "Enter 'type' to select events based on type (Talks, Screenings, etc.)"
    puts "Or type 'next' to see a list of events"
    first_input = gets.strip
    case first_input
    when "type"
      Aic::EventType.select_type
      Aic::EventType.type_info
      #go into EventType and grab events
    when "next"
    current_hash = Hash.new(v=[])
    @@all.each.with_index(1) {|e, i| current_hash[i] =  ["#{e.title}", "#{e.type.name}"]}
    if current_hash.size >= 20
      nested_arrays = current_hash.to_a.each_slice(20).to_a
        if @@counter <= nested_arrays.size
          nested_arrays[@@counter].each do |nest|
            puts "#{nest[0]}. #{nest[1][0]} (#{nest[1][1]})"
          end #nested_arrays
        end #@@counter if
      else
        current_hash.each {|k,v| puts "#{k}. #{v[0]} (#{v[1]})}"}
    end
    puts "Enter an event name or number for dates, times, and description."
    puts "Or enter 'more' to see the next 20 events."
    input = gets.strip
    if current_hash.detect {|k,v| v.include?("#{input}") || k == "#{input}".to_i}
      sleep(0.5)
      self.event_info(current_hash, input)
    elsif input == "more" #working #puts next twenty results and returns to the main menu
      sleep(0.5)
      @@counter += 1
      event_menu
    elsif input == "type"
      #puts out a numbered list of types applicable to events in the date range
      Aic::EventType.all.each {|k,v| puts "#{k}"}
     elsif current_hash.none? {|k,v| v.include?("#{input}") || k == "#{input}".to_i}
       sleep(0.5)
       puts "Sorry! I can't find that event."
       event_menu
     end #outer if statement
   end #case statement
  end #event_menu

  def self.event_info(event_hash, input)
    occurs = []
    @@all.each do |event|
      if event.title.include? (event_hash.detect {|k,v| v.include?("#{input}") || k == "#{input}".to_i}[1][0])
        occurs << event
      end #if statement
    end # all each end
    occurs
      puts "#{occurs[0].title}"
      puts "#{occurs[0].type.name}"
      puts "#{occurs[0].description}"
      puts "When:"
    occurs.each do |e|
      puts "#{e.date.strftime("%m-%d-%Y")}"
      puts "#{e.time}"
      puts "#{e.url}"
      puts ""
    end #occurs each
  end #event_info


end
