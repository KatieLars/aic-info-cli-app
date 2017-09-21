class Aic::Exhibition
  attr_accessor :title, :date_range, :url, :description, :location
  @@current = []
  @@upcoming = []

  def self.scrape_from_web(url) #scrapes creates Exhibit objects from either upcoming or current website
    doc = Nokogiri::HTML(open("#{url}"))
    exhibit_array = doc.css("div.view.view-exhibitions div.views-row")
    exhibit_array.each do |xml_element|
      new_exhibit = Aic::Exhibition.new
      new_exhibit.title = xml_element.css("div.views-field.views-field-title span.field-content").text.tr("\n", "")
      new_exhibit.date_range = xml_element.css("strong.views-field.views-field-field-event-date div.field-content").text
      new_exhibit.location = xml_element.css("div.views-field.views-field-field-exhibition-room div.field-content").text
      new_exhibit.description = xml_element.css("div.views-field.views-field-body span.field-content").first.text.strip
      new_exhibit.url = "http://www.artic.edu" + xml_element.css("div.views-field.views-field-title span.field-content a").attribute("href").text
      if url.include?("current")
        @@current << new_exhibit
      elsif url.include?("upcoming")
        @@upcoming << new_exhibit
      end #if/else
    end #each
  end #scrape_from_web

  def self.current #returns array of current Exhibit objects
    @@current
  end

  def self.upcoming
    @@upcoming
  end

end
