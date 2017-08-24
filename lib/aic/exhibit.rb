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
      new_exhibit.description = xml_element.css("div.views-field.views-field-body span.field-content").text
      new_exhibit.url = xml_element.css("div.views-field.views-field-title span.field-content a").attribute("href").text
      if url.include?("current")
        @@current << new_exhibit
      elsif url.include?("upcoming")
        @@future << new_exhibit
      end #if/else
    end #do

  end #initialize

  def self.current #creates & returns new Exhibit object based on current site
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
