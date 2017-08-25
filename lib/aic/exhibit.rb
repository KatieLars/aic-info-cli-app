class Aic::Exhibit
  attr_accessor :title, :date_range, :url, :description, :location
  @@current = []
  @@future = []

  def self.scrape_from_web(url) #scrapes creates Exhibit objects from either upcoming or current website
    doc = Nokogiri::HTML(open("#{url}"))
    exhibit_array = doc.css("div.view.view-exhibitions div.views-row") #creates an array of nodes to iterate over and select info
    exhibit_array.each do |xml_element| #try to refactor with send
      new_exhibit = Aic::Exhibit.new
      new_exhibit.title = xml_element.css("div.views-field.views-field-title span.field-content").text.tr("\n", "")
      new_exhibit.date_range = xml_element.css("strong.views-field.views-field-field-event-date div.field-content").text
      new_exhibit.location = xml_element.css("div.views-field.views-field-field-exhibition-room div.field-content").text
      new_exhibit.description = xml_element.css("div.views-field.views-field-body span.field-content").first.text
      new_exhibit.url = xml_element.css("div.views-field.views-field-title span.field-content a").attribute("href").text
      if url.include?("current")
        @@current << new_exhibit
      elsif url.include?("upcoming")
        @@future << new_exhibit
      end #if/else
    end #do
  end #scrape_from_web

  def self.exhibit_info(type)
    #need to use the input of type to invoke new class methods
    current_hash = {} #hash with index being key and exhibit tile as value
    y = Aic::Exhibit.send ("#{type}=", []) #should 
    self.scrape_from_web("http://www.artic.edu/exhibitions/#{type}")
    Aic::Exhibit.send ("#{type}=", []).each.with_index(1) {|e, i| puts "#{i}. #{e.title}"}
    @@current.each.with_index(1) {|e, i| current_hash[i] =  "#{e.title}"}
    puts "Enter the name of the exhibit or its number for dates, times, and description"
    new_input = gets.strip
    @@.each do |exhibit| #iterates over an array of Exhibit Objects and returns info for that event
      if !new_input.to_i.is_a?(Integer) && exhibit.title == current_hash.each {|k,v| v.include?("#{new_input}")}[1]
       puts "#{exhibit.title}"
       puts "#{exhibit.date_range}"
       puts "#{exhibit.location}"
       puts "#{exhibit.description}"
       puts "#{exhibit.url}"
     elsif new_input.to_i.is_a?(Integer) && exhibit.title == current_hash[new_input.to_i]
        puts "#{exhibit.title}"
        puts "#{exhibit.date_range}"
        puts "#{exhibit.location}"
        puts "#{exhibit.description}"
        puts "#{exhibit.url}"
      else
        puts "Sorry! I didn't recognize that exhibit."
        self.exhibit_info(type)
      end  #if statement end
    end #each statement end
  end #exhibit_info

  def self.current #returns array of current Exhibit objects
    @@current
  end

  def self.future
    @@future
  end
  #type lock @@current and @@future as Exhibit objects
  #Each Exhibit has: a title, a date, now or future category, a url, description, and location
    #this is a place to store data
    #@exhibit_dates should just return a string scraped from the Exhibits page
end
