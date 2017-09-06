require 'nokogiri'
class Aic::Info
  @@adults = {}
  @@seniors = {}
  @@students = {}
  @@teens = {}

  def self.scrape_admission(livin)

    doc = Nokogiri::HTML(open("http://www.artic.edu/visit"))
    price_array = doc.css("div.pricing-container") #only 1 element--Nodeset
    price_array.each do |xml_element|
      @@adults["General"] = price_array.css("tr:nth-child(2) td.pricing-ga").text
      @@adults["Chicago"] = price_array.css("tr:nth-child(2) td.pricing-chires").text
      @@adults["Illinois"] = price_array.css("tr:nth-child(2) td.pricing-illres").text
      @@seniors["General"] = price_array.css("tr:nth-child(3) td.pricing-ga").text
      @@seniors["Chicago"] = price_array.css("tr:nth-child(3) td.pricing-chires").text
      @@seniors["Illinois"] = price_array.css("tr:nth-child(3) td.pricing-illres").text
      @@students["General"] = price_array.css("tr:nth-child(4) td.pricing-ga").text
      @@students["Chicago"] = price_array.css("tr:nth-child(4) td.pricing-chires").text
      @@students["Illinois"] = price_array.css("tr:nth-child(4) td.pricing-illres").text
      @@teens["General"] = price_array.css("tr:nth-child(5) td.pricing-ga").text
      @@teens["Chicago"] = price_array.css("tr:nth-child(5) td.pricing-chires").text
      @@teens["Illinois"] = price_array.css("tr:nth-child(5) td.pricing-illres").text
    end

    binding.pry

  end #scrape_admission end

  def self.prices(residency)
    case residency
    when "General"

      puts "Adults: #{@@adults["General"]}"
      puts "Seniors (65+): #{@@seniors["General"]}"
      puts "Students: #{@@students["General"]}"
      puts "Teens (ages 14-17): #{@@teens["General"]}"
    when "Illinois"
      puts "Adults: #{@@adults["Illinois"]}"
      puts "Seniors (65+): #{@@seniors["Illinois"]}"
      puts "Students: #{@@students["Illinois"]}"
      puts "Teens (ages 14-17): #{@@teens["Illinois"]}"
    when "Chicago"
      puts "Adults: #{@@adults["Chicago"]}"
      puts "Seniors (65+): #{@@seniors["Chicago"]}"
      puts "Students: #{@@students["Chicago"]}"
      puts "Teens (ages 14-17): #{@@teens["Chicago"]}"
    when "Free"
      puts "Kids under 14 are always free"
      puts "Free Thursday evenings for Illinois residents"

      #scrapes code for free admission opportunities and re-organizes it
    end #case end
  end #prices


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
