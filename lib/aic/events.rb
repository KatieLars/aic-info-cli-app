require 'Chronic'
class Aic::Events # HAS ONE EventType
  attr_accessor :title, :type, :date, :time, :url, :summary

  def initialize
    @time = {}
  end
  

  #:date will have to convert the scraped text into a Time object to compare against user input. <=> may be useful as a Time method
  #use Chronic to convert scraped info into Time objects
  #time is a hash
end
