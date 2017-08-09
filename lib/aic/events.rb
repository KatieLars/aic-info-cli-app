class AIC::Events
  attr_accessor :title, :type, :date, :time, :url, :summary

  #:date will have to convert the scraped text into a Time obect to compare against user input.
end
