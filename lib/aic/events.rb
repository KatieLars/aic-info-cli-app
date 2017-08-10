require 'Chronic'
class Aic::Events #an Event HAS MANY EventDates, HAS ONE EventType
  attr_accessor :title, :type, :date, :time, :url, :summary

  #:date will have to convert the scraped text into a Time object to compare against user input. <=> may be useful as a Time method
  #use Chronic to convert scraped info into Time objects
end
