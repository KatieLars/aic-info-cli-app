class Aic::Exhibit
  attr_accessor :title, :date_range, :url, :description, :location
  @@current = []
  @@future = []

#HOOK IS SCRAPER
  def initialize(url) #scrapes creates Exhibit objects from either upcoming or current website
    doc = Nokogiri::HTML(open("#{url}"))
    exhibit_array = doc.css("div.view.view-exhibitions div.views-row") #creates an array of nodes to iterate over and select info
    exhibit_array.each do |xml_element|
      Exhibit.title = xml_element.css("div.views-field.views-field-title span.field-content").text.tr("\n", "")
      Exhibit.date_rage = xml_element.css("strong.views-field.views-field-field-event-date div.field-content").text
      Exhibit.location = xml_element.css("div.views-field.views-field-field-exhibition-room div.field-content").text
      Exhibit.description = xml_element.css("div.views-field.views-field-body span.field-content").text
      Exhibit.url = xml_element.css("div.views-field.views-field-title span.field-content a").attribute("href").text
    end #do
    if url.include?("current")
      self << @@current
    elsif url.include?("upcoming")
      self << @@future
    end #if/else
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
