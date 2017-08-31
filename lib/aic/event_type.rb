class Aic::EventType #HAS MANY Events
  attr_accessor :name, :events
  @@all = Hash.new(v = @events)
  @@counter = 0

  def initialize(name)
    @events = []
    if name != ""
      @name = name #add new key and value if one does not already exist
    else
      @name = "Misc"
    end
    add_events
  end

  def add_events #adds Event object to @event array, and returns updated list
    Aic::Event.all.each do |event_object|
      if event_object.type.name == @name
        @events << event_object
      end
        @@all[@name] = @events
    end
  end

  def self.all
    @@all
  end

  def self.select_type #return a numbered list of available Types 20 at a time
    if @@all.size >= 20
      nested_arrays = @@all.to_a.each_slice(20).to_a
        if @@counter <= nested_arrays.size
          nested_arrays[@@counter].each do |nest|
            puts "#{nest[0]}. #{nest[1][0]} (#{nest[1][1]})"
          end #nested_arrays
        end #@@counter if
      else
         @@all.each {|k,v| puts "#{@@counter += 1}. #{k}"}
      end #@@all > 20
  end

  #EventTypes have: a list of all Event objects that correspond to them. They also have names generated from a scraper
  #@@all is a hash that keeps track of how many of each Event type there is. Keys are EventType objects and values are the number of that type.
  #Types should only be added to EventType iff there isn't already one present in the hash. Otherwise, the values for the
    #appropriate key should tick up one.
  #Control for type: events should always be Event objects

end
