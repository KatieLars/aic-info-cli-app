class Aic::Exhibit
  attr_accessor :title, :date_range, :url, :description, :location
  @@current = []
  @@future = []

  def self.current
    @@current
  end #self.current end

  def self.future
    @@future
  end #self.future end


  #type lock @@current and @@future as Exhibit objects
  #Each Exhibit has: a title, a date, now or future category, a url, description, and location
    #this is a place to store data
    #@exhibit_dates should just return a string scraped from the Exhibits page
end
