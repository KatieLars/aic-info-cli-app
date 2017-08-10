class Aic::EventType
  attr_accessor :name, :events
  @@all = {}
  
  def initialize
    @events = []
  end

end
