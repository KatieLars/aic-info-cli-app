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
    #@@counter may be able to be formatted as a local variable
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

  def self.type_info #select a type from the list above, and its going to puts out a list of events
    puts "Select an event type or number to see a list of all that type of event"
    current_hash = Hash.new
    @@all.each {|k,v| current_hash[@@counter += 1] = "#{v}"}
    binding.pry
    input = gets.strip
    #returns list of event names for selected type
    #user types in option from select_type or number
    #access @@all to return the appropriate Event object titles (20 at a time)
    #list of Event object titles, and user can select specific event
    case input
    when #word found in event type or number corresponding to list
      #pops into @@all, selects the appropriate type key, and returns values as list, 20 at a time
      #pops back into Events to get info for selected events
    when "more"
      #puts the next 20 in list and run type_info again
    when #anything else
      puts "Sorry! I didn't recoginze that event type."
      type_info
    end #case end

  end

  #EventTypes have: a list of all Event objects that correspond to them. They also have names generated from a scraper
  #@@all is a hash that keeps track of how many of each Event type there is. Keys are EventType objects and values are the number of that type.
  #Types should only be added to EventType iff there isn't already one present in the hash. Otherwise, the values for the
    #appropriate key should tick up one.
  #Control for type: events should always be Event objects

end
