class Aic::Exhibit
  attr_accessor :title, :date_range, :url, :description, :location
  @@current = []
  @@future = []

  def self.new_from_site(url)
    exhibit = Exhibit.new
    ex_properties = Scraper.scrape_exhibits(url)
    if url.include?("current")
      exhibit << @@current
    elsif url.include?("upcoming")
      exhibit << @@future
    end

  end #self.current end

  def self.future
    future_ex = Exhibit.new
    ex_properties = Scraper. scrape_exhibits("http://www.artic.edu/exhibitions/upcoming")
    future_ex << @@future
  end #self.future end


  #type lock @@current and @@future as Exhibit objects
  #Each Exhibit has: a title, a date, now or future category, a url, description, and location
    #this is a place to store data
    #@exhibit_dates should just return a string scraped from the Exhibits page
end
