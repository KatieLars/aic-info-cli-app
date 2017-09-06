require 'nokogiri'
class Aic::Info
  @@adults = {}
  @@seniors = {}
  @@students = {}
  @@teens = {}

  def self.scrape_admission

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

  end #scrape_admission end

  def self.prices(residency)
    doc = Nokogiri::HTML(open("http://www.artic.edu/visit"))

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
      free_info = []
      free_desc = []
      free_hash ={} #key is header from free_info, value is description from free_desc
      doc.css("h2#FreeAdmissionOpportunities ~ h4").to_a.each do |e|
        free_info << e.text #keys
      end
      doc.css("h2#FreeAdmissionOpportunities ~ p").to_a.each do |e|
        free_desc << e.text #values
      end
      passport_desc = free_desc.slice!(-1).split(".")
      passport_desc.slice!(-1)
      free_desc.slice!(-1) #useless element
      passport_head = free_info.slice!(-1)
      free_hash = Hash[free_info.zip(free_desc)]
      free_hash.each do |k,v|
        puts "#{k}"
        puts "#{v}"
        puts ""
      end
      puts "#{passport_head}"
      puts "#{passport_desc.join(".")}.)"
      #scrapes code for free admission opportunities and re-organizes it
    end #case end
  end #prices

  #scraper should also scrape for EventTypes and they should be added to EventType.all if they are new and
  #scraper should scrape code from Exhibit page, Calendar page, Admission page, Description pages for individual Events and exhibits
  #should generate: Exhibit object and Event object
  #puts admissions information
  #needs to interact with all objects
end
