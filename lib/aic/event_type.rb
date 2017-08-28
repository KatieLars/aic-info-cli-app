class Aic::EventType #HAS MANY Events
  attr_accessor :name, :events
  @@all = Hash.new(v = @events)

  def initialize(name)
    @events = [] #array of Event objects
    @name = name #add new key and value if one does not already exist
    @@all[@name] = self.add_events
binding.pry
  end

  def add_events #adds Event object to @event array, and returns updated list
    #problem: right now, events array is blank
    Aic::Event.all.each do |event_object|
    if event_object.type == @name
      @events << event_object
    end
    @events
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
