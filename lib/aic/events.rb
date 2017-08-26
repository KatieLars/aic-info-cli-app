
class Aic::Events # HAS ONE EventType, HAS ONE EventDate
  attr_accessor :title, :type, :event_date, :time, :url, :summary
  @@all = []

  def self.scrape_from_web(url)
    doc = Nokogiri::HTML(open("#{url}"))
    event_array = doc.css(
  end #scraper


  #event_date is Time object
  #Dates should only be added to the hash if there isn't already
  #type lock @time, @event_date
end
