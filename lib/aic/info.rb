require 'nokogiri'
class Aic::Info

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

#  def self.scrape_exhibits(url) #creates Exhibit objects from either upcoming or current website
#    new_exhibit = Aic::Exhibit.new
#    doc = Nokogiri::HTML(open("#{url}"))
#    exhibit_array = doc.css("div.view.view-exhibitions div.views-row") #creates an array of nodes to iterate over and select info
#    y = exhibit_array.each do |xml_element|
#      new_exhibit.title = xml_element.css("div.views-field.views-field-title span.field-content").text.tr("\n", "")
#      new_exhibit.date_range = xml_element.css("strong.views-field.views-field-field-event-date div.field-content").text
#      new_exhibit.location = xml_element.css("div.views-field.views-field-field-exhibition-room div.field-content").text
#      new_exhibit.description = xml_element.css("div.views-field.views-field-body span.field-content").text
#      new_exhibit.url = xml_element.css("div.views-field.views-field-title span.field-content a").attribute("href").text
#      @@exhibits << new_exhibit
#    end
#  end #scrape_exhibits end

  #scraper should also scrape for EventTypes and they should be added to EventType.all if they are new and
  #scraper should scrape code from Exhibit page, Calendar page, Admission page, Description pages for individual Events and exhibits
  #should generate: Exhibit object and Event object
  #puts admissions information
  #needs to interact with all objects
end
