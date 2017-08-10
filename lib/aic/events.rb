
class Aic::Events # HAS ONE EventType, HAS ONE EventDate
  attr_accessor :title, :type, :event_date, :time, :url, :summary

  def initialize
    @event_date = {}
  end

  #event_date is a hash:
    #keys are Event_Date objects scraped from the web, and values are an array of all the Event objects that correspond the that date
  #Dates should only be added to the hash if there isn't already
  #type lock @time, @event_date
end
