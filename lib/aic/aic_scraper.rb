require 'Nokogiri'
class Aic::Scraper #I just scrape stuff. Scrip-scrap-scrape, and can see all other objects

  def self.scrape_admission(residency)
    case residency
    when "General"
      #scrapes code for General admission and re-organizes it
    when "Illinois"
      #scrapes code for Illinois residents and re-organizes it
    when "Chicago"
      #scrapes code for Chicago residents and re-organizes it
    when "Free"
      #scrapes code for free admission opportunities and re-organizes it
    end #case end
  end #general admission end

  def self.scrape_current_exhibits #creates Exhibit objects from a website
    doc = Nokogiri::HTML(open("http://www.artic.edu/exhibitions/current"))
    counter = 1
    title_array = doc.css("div.views-field.views-field-title span.field-content").text.split(/\n/)
    title_array.each do |title|
      Exhibit.new
      Exhibit.title = title
      counter += 1
    end
    #scrapes a list of current exhibits from pages and creates Exhibit objects with the following properties:
      #title, url, date_range, description, location, and adds it to @@current
  end #scrape_current end

  def self.scrape_future_exhibits
    #doc = Nokogiri :: HTML (HARD CODE UPCOMING URL HERE)
    #scrapes a list of current exhibits from pages and creates Exhibit objects with the following properties:
      #title, url, date_range, description, location, and adds it to @@future
  end #scrape_future end

  #scraper should also scrape for EventTypes and they should be added to EventType.all if they are new and
  #scraper should scrape code from Exhibit page, Calendar page, Admission page, Description pages for individual Events and exhibits
  #should generate: Exhibit object and Event object
  #puts admissions information
  #needs to interact with all objects
end
