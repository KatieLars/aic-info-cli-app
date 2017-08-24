require 'chronic'
class Aic::EventDate #HAS MANY Event objects
  attr_accessor :title, :events
  @@all = []

  def initialize
    @events = []
  end

  #This is a test

  # will have to convert the scraped text into a Time object to compare against user input. <=> may be useful as a Time method
  #use Chronic to convert scraped info into Time objects
  #@events is an array that lists all the Event objects that occur on this date
  #@@all will keep track of all the EventDate objects in order, with the the most recent first
  #type lock @events
  #@title will just return a string in this format: "Friday, Aug 11, 2017"
end
