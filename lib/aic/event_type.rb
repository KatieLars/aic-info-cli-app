class Aic::EventType #HAS MANY Events
  attr_accessor :name, :events #events is a list of all events for a specific date
  @@all = {} #key is event type, value is an array listing all events for that type

  def initialize(name)
    @events = []
    @name = name
  end

  def self.add_to_all
    new_event = Aic::Event.new
    if @@all.none? {|k,v| k == new_event.type}
      @@all[new_event.type] =
    end

  end

  def add_events #adds Event object to @event array
    new_event = Aic::Event.new
    if new_event.type == @name
      @events << new_event
    end
  end

  def self.all
    @@all
  end

  #EventTypes have: a list of all Event objects that correspond to them. They also have names generated from a scraper
  #@@all is a hash that keeps track of how many of each Event type there is. Keys are EventType objects and values are the number of that type.
  #Types should only be added to EventType iff there isn't already one present in the hash. Otherwise, the values for the
    #appropriate key should tick up one.
  #Control for type: events should always be Event objects

end
