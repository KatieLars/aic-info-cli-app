require 'nokogiri'
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

  def self.scrape_exhibits(url) #creates Exhibit objects from either upcoming or current website
    doc = Nokogiri::HTML(open("#{url}"))
    exhibit_array = doc.css("div.view.view-exhibitions div.views-row") #creates an array of nodes to iterate over and select info
    exhibit_array.each do |xml_element|

      Exhibit.title = xml_element.css("div.views-field.views-field-title span.field-content").text.tr("\n", "")
      Exhibit.date_rage = xml_element.css("strong.views-field.views-field-field-event-date div.field-content").text
      Exhibit.location = xml_element.css("div.views-field.views-field-field-exhibition-room div.field-content").text
      Exhibit.description = xml_element.css("div.views-field.views-field-body span.field-content").text
      Exhibit.url = xml_element.css("div.views-field.views-field-title span.field-content a").attribute("href").text
    end
  end #scrape_exhibits end

  #scraper should also scrape for EventTypes and they should be added to EventType.all if they are new and
  #scraper should scrape code from Exhibit page, Calendar page, Admission page, Description pages for individual Events and exhibits
  #should generate: Exhibit object and Event object
  #puts admissions information
  #needs to interact with all objects
end
