
class Aic::Event # HAS ONE EventType, HAS ONE EventDate
  attr_accessor :title, :type, :date, :time, :url, :description
  @@all = [] #array with all events

  def self.scrape_from_web(url) #creates Event objects from URL
    doc = Nokogiri::HTML(open("#{url}"))
    event_array = doc.css("div.calendar_result div.views-row")
    event_array.each do |xml_element| #try to refactor with send
      new_event = Aic::Event.new
      new_event.title = xml_element.css("div.col-wrapper.clearfix div.col-inner div.title.views-field.views-field-title").text
      new_event.type = Aic::EventType.new(xml_element.css("div.col-wrapper.clearfix div.col-inner div.views-field.views-field-taxonomy").text) #should hook into EventType
      #need to create a new EventType object
      new_event.date = Chronic.parse(xml_element.css("div.col-wrapper.clearfix div.col-inner div.date.views-field").text)
      new_event.description = xml_element.css("div.col-wrapper.clearfix div.col-inner div.summary.views-field p").text.strip
      new_event.url = "http://www.artic.edu" + xml_element.css("div.col-wrapper.clearfix div.col-inner div.title.views-field.views-field-title a").attribute("href").text
      new_event.time = xml_element.css("div.col-wrapper.clearfix div.col-inner div.time.views-field").text
      @@all << new_event

    end
  end #scraper

  def self.all
    @@all
  end

  def self.event_menu(counter = 0)
    current_hash = Hash.new(v=[])#key is index of array, and value is array with title and type as elements
    @@all.each.with_index(1) {|e, i| current_hash[i] =  ["#{e.title}", "#{e.type.name}"]}
    nested_arrays = current_hash.to_a.each_slice(20).to_a
    nested_arrays.size #6
    variable_set(counter +=1)
    y = nested_arrays[0]
    x = nested_arrays[1]
    z = nested_arrays[2]
    a = nested_arrays[3]
    b = nested_arrays[4]
    c = nested_arrays[5]
    counter = 0
    if counter <=20
    nested_arrays.each do |twenty|
      twenty.each do |nest| #for each nested array, puts o
        puts "#{nest[0]}. #{nest[1][0]} (#{nest[1][1]})"
        counter += 1
      end
    end #nested_arrays
  end
  end

  def self.first_menu
    current_hash = Hash.new(v=[])#key is index of array, and value is array with title and type as elements
    @@all.each.with_index(1) {|e, i| current_hash[i] =  ["#{e.title}", "#{e.type.name}"]}
    current_hash.collect {|k,v| puts "#{k}. #{v[0]} (#{v[1]})"} #does this for first 20 pair
    puts "Enter exhibition name or number for dates, times, and description."
    puts "Or enter 'more' to see the next 20 events."
  end

  def self.event_info #generates event info depending on user inp
    current_hash = Hash.new(v=[])#key is index of array, and value is array with title and type as elements
    @@all.each.with_index(1) {|e, i| current_hash[i] =  ["#{e.title}", "#{e.type.name}"]}
    #current_hash.collect {|k,v| puts "#{k}. #{v[0]} (#{v[1]})"} #does this for first 20 pair
    #puts "Enter exhibition name or number for dates, times, and description."
    #puts "Or enter 'more' to see the next 20 events."
    input = gets.strip
    if current_hash.detect {|k,v| v.include?("#{input}") || k == "#{input}".to_i}
      occurs = []
      @@all.each do |event|
        if event.title.include? (current_hash.detect {|k,v| v.include?("#{input}") || k == "#{input}".to_i}[1][0])
          occurs << event
        end #if statement
      end # all each end
      occurs
        puts "#{occurs[0].title}"
        puts "#{occurs[0].type.name}"
        puts "#{occurs[0].description}"
        puts ""
        puts "When:"
      occurs.each do |e|
        puts "#{e.date.strftime("%m-%d-%Y")}"
        puts "#{e.time}"
        puts "#{e.url}"
        puts ""
      end #occurs each
    elsif input == "more"
      self.event_menu(counter += 1)
      #nested_arrays[counter].each do |nest|
      #  puts "#{nest[0]}. #{nest[1][0]} (#{nest[1][1]})"
      #end #nested_arrays
      event_info
     elsif current_hash.none? {|k,v| v.include?("#{input}") || k == "#{input}".to_i}
       puts "Sorry! I can't find that event."
       event_info
     end #outer if statement
  end #exhibit_info
  #event_date is Time object
  #Dates should only be added to the hash if there isn't already
  #type lock @time, @event_date
end
