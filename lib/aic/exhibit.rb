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

  def self.exhibit_info(type) #generates exhibit info depending on user input
    current_hash = {} #hash with index being key and exhibit tile as value
    scrape_from_web("http://www.artic.edu/exhibitions/#{type}")
    send("#{type}").each.with_index(1) {|e, i| current_hash[i] =  "#{e.title}"}
    current_hash.each {|k,v| puts "#{k}. #{v}"}
    puts "Enter the name of the exhibit or its number for dates, times, and description"
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
       puts "Sorry! I can't find that exhibit."
       exhibit_info(type) #need to not accumulate lists . . . 
     end #outer if statement
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
