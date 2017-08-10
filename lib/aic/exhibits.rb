class Aic::Exhibits
  attr_accessor :title, :date_range, :now_or_future, :url, :description, :location
  @@current = []
  @@future = []

  #@@current & @@future is an array that stores all Exhibit objects that have an @now_or_future of "current" or "upcoming" (aka future)
  #type lock @@current and @@future as Exhibit objects
  #Each Exhibit has: a title, a date, now or future category, a url, description, and location
    #this is a place to store data
    #@exhibit_dates should just return a string scraped from the Exhibits page
end
