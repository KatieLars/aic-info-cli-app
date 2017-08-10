class Aic::EventType #this will be modeled on the Genres class 
  attr_accessor :name, :events
  @@all = {}

  def initialize
    @events = []
  end

end
