class Aic::EventType #this will be modeled on the Genres class--an event type HAS MANY Events
  attr_accessor :name, :events
  @@all = {}

  def initialize
    @events = []
  end

end
