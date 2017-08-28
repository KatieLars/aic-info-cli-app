
class Aic::Event # HAS ONE EventType, HAS ONE EventDate
  attr_accessor :title, :type, :event_date, :time, :url, :description
  @@all = []

  def self.scrape_from_web(url)
    doc = Nokogiri::HTML(open("#{url}"))
    event_array = doc.css("div.calendar_result div.views-row")
    event_array.each do |xml_element| #try to refactor with send
      new_event = Aic::Event.new
      new_event.title = xml_element.css("div.col-wrapper.clearfix div.col-inner div.title.views-field.views-field-title").text

      new_event.type = Aic::EventType.new(xml_element.css("div.col-wrapper.clearfix div.col-inner div.views-field.views-field-taxonomy").text).name #should hook into EventType
      #need to create a new EventType object
      new_event.event_date = Chronic.parse(xml_element.css("div.col-wrapper.clearfix div.col-inner div.date.views-field").text)
      new_event.description = xml_element.css("div.col-wrapper.clearfix div.col-inner div.summary.views-field p").text
      new_event.url = "http://www.artic.edu" + xml_element.css("div.col-wrapper.clearfix div.col-inner div.title.views-field.views-field-title a").attribute("href").text
      new_event.time = xml_element.css("div.col-wrapper.clearfix div.col-inner div.time.views-field").text
      @@all << new_event
    end
    binding.pry
  end #scraper

  def self.all
    @@all
  end
  #event_date is Time object
  #Dates should only be added to the hash if there isn't already
  #type lock @time, @event_date
end
