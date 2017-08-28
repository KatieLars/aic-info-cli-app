
class Aic::Event # HAS ONE EventType, HAS ONE EventDate
  attr_accessor :title, :type, :event_date, :time, :url, :description
  @@all = [] #array with all events

  def self.scrape_from_web(url) #creates Event objects from URL
    doc = Nokogiri::HTML(open("#{url}"))
    event_array = doc.css("div.calendar_result div.views-row")
    event_array.each do |xml_element| #try to refactor with send
      new_event = Aic::Event.new
      new_event.title = xml_element.css("div.col-wrapper.clearfix div.col-inner div.title.views-field.views-field-title").text
      new_event.type = Aic::EventType.new(xml_element.css("div.col-wrapper.clearfix div.col-inner div.views-field.views-field-taxonomy").text) #should hook into EventType
      #need to create a new EventType object
      new_event.event_date = Chronic.parse(xml_element.css("div.col-wrapper.clearfix div.col-inner div.date.views-field").text)
      new_event.description = xml_element.css("div.col-wrapper.clearfix div.col-inner div.summary.views-field p").text
      new_event.url = "http://www.artic.edu" + xml_element.css("div.col-wrapper.clearfix div.col-inner div.title.views-field.views-field-title a").attribute("href").text
      new_event.time = xml_element.css("div.col-wrapper.clearfix div.col-inner div.time.views-field").text
      @@all << new_event
    end
  end #scraper

  def self.all
    @@all
  end

  def self.event_info #generates event info depending on user input
    current_hash = Hash.new(v=[])#key is index of array, and value is array with title and type as elements
    y = @@all.each.with_index(1) {|e, i| current_hash[i] =  ["#{e.title}", "#{e.type.name}"]}
binding.pry
    current_hash.each {|k,v| puts "#{k}. #{v[0]} (#{v[1]})"}
    puts "Enter the name of the exhibition or its number for dates, times, and description"
    new_input = gets.strip
    if current_hash.detect {|k,v| v.include?("#{new_input}") || k == "#{new_input}".to_i}
      send("#{type}").each do |exhibit|
        if exhibit.title.include? (current_hash.detect {|k,v| v.include?("#{new_input}") || k == "#{new_input}".to_i}[1])
          puts "#{exhibit.title}"
          puts "#{exhibit.date_range}"
          puts "#{exhibit.location}"
          puts "#{exhibit.description}"
          puts "#{exhibit.url}"
        end #inner if statement must stay
      end #each end
     elsif current_hash.none? {|k,v| v.include?("#{new_input}") || k == "#{new_input}".to_i}
       puts "Sorry! I can't find that exhibition."
       exhibit_info(type) #need to not accumulate lists . . .
     end #outer if statement
  end #exhibit_info
  #event_date is Time object
  #Dates should only be added to the hash if there isn't already
  #type lock @time, @event_date
end
