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

  def self.select_type #generates a list of types for specified date range
    type_hash = Hash.new
    @@all.to_a.each.with_index(1) {|e,i| type_hash[i] = "#{e[0]}"}
    type_hash.each {|k,v| puts "#{k}. #{v}"}
    puts "Select an event type or number to see a list of all that type of event"
  end

  def self.event_list #lists events based on type
    input = gets.strip #this input is the selection of a type
    current_hash = Hash.new
    @@all.to_a.each.with_index(1) {|e,i| current_hash[i] = "#{e[0]}"}
    @@all.each do |k,v| #needs to match the detected type name
      if k.include? (current_hash.detect {|k,v| v.include?("#{input}") || k == "#{input}".to_i}[1])
        #returns list of first 20 events
        if v.size >= 20 #v is an array of Event Objects
          split_array = v.each_slice(20).to_a
          split_array[@@counter].each.with_index(1) do |event_obj,i|
            puts "#{i}. #{event_obj.title} (#{event_obj.type.name})"
          end #split_array each
        else
          v.each {|event_object| puts "#{@@counter += 1}. #{event_object.title}"}
        end #v.size
      end #if statement k.include?
    end #all each statement
      puts "Enter an event name or number for dates, times, and description."
      puts "Or enter 'more' to see the next 20 events."
      input_1 = gets.strip
      if current_hash.detect {|k,v| v.include?("#{input_1}") || k == "#{input_1}".to_i}
        sleep(0.5)
        Aic::Event.event_info(current_hash, input)
      elsif input == "more" #reveals next 20 events
          @@counter += 1
          self.event_list
      elsif current_hash.none? {|k,v| v.include?("#{input}") || k == "#{input}".to_i}
          sleep(0.5)
          puts "Sorry! I can't find that event."
          event_list
      end #big if statement
  end

  #def self.type_info #select a type from the list above, and its going to puts out a list of events
  #  current_hash = Hash.new
  #  @@all.to_a.each.with_index(1) {|e,i| current_hash[i] = "#{e[0]}"}
  #  input = gets.strip
    #user types in option from select_type or number
    #access @@all to return the appropriate Event object titles (20 at a time)
    #list of Event object titles, and user can select specific event
  #  if current_hash.detect {|k,v| v.include?("#{input}") || k == "#{input}".to_i}
  #    self.event_list
  #    elsif input == "more" #reveals next 20 events
  #      @@counter += 1
  #      self.event_list
      #pops into @@all, selects the appropriate type key, and returns values as list, 20 at a time
      #pops back into Events to get info for selected events
    #when "more"
      #puts the next 20 in list and run type_info again
    #when #anything else
      #puts "Sorry! I didn't recoginze that event type."
      #type_info
    #end #big if statement

  #end

  #EventTypes have: a list of all Event objects that correspond to them. They also have names generated from a scraper
  #@@all is a hash that keeps track of how many of each Event type there is. Keys are EventType objects and values are the number of that type.
  #Types should only be added to EventType iff there isn't already one present in the hash. Otherwise, the values for the
    #appropriate key should tick up one.
  #Control for type: events should always be Event objects

end
