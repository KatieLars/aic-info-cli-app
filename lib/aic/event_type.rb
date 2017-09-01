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

  def self.event_list #lists events based on type PROBLEM WITH INPUTS
    input = gets.strip #this input is the selection of a type
    current_hash = Hash.new
    select_event_hash = Hash.new #an array of all Event objects corresponding to selected type
    @@all.to_a.each.with_index(1) {|e,i| current_hash[i] = "#{e[0]}"}
        @@all.each do |k,v| #needs to match the detected type name or
          if k.include? (current_hash.detect {|k,v| v.include?("#{input}") || k == "#{input}".to_i}[1])
        #returns list of first 20 events
            v.each.with_index(1) {|e_obj, i| select_event_hash[i] = e_obj}
          if v.size >= 20 #v is an array of Event Objects
            split_array = v.each_slice(20).to_a
            split_array[@@counter].each.with_index(1) do |event_obj,i|
              puts "#{i}. #{event_obj.title} (#{event_obj.type.name})"
            end #split_array each
          else
            v.each {|event_object| puts "#{@@counter += 1}. #{event_object.title}"}
          end #v.size this returns a 20 item list
      end #all each statement
    end #if statement
    #select_event_array
      puts "Enter an event name or number for dates, times, and description."
      puts "Or enter 'more' to see the next 20 events."
      event_details(select_event_hash) #events of the select type

  end #event_list
#remember that@@all points to an array (v is an array)
  def self.event_details(a_hash) #generates details for list or next 20 in list
      input_1 = gets.strip #this input is an event indicator or "more"
      #selecting an event to get the deets
      if a_hash.detect {|k,v|  v.title.include?("#{input_1}") || k == "#{input_1}".to_i}
        #input matches presented event options

        #need to take out all events matching that input
        found_events = [] #array of all events fitting input
         y = a_hash.detect {|k,v|  v.title.include?("#{input_1}") || k == "#{input_1}".to_i}[1]
         found_events << a_hash.detect {|k,v|  v.title.include?("#{input_1}") || k == "#{input_1}".to_i}[1]

        puts "#{found_events[0].title}"
        puts "#{found_events[0].type.name}"
        puts "#{found_events[0].description}"
        puts "When:"
        binding.pry
      y.each do |e|
        puts "#{e.date.strftime("%m-%d-%Y")}"
        puts "#{e.time}"
        puts "#{e.url}"
        puts ""
      end #y[1]
    end #a_hash detect
     #if select_event_hash.detect {|k,v|  v.title.include?("#{input_1}") || k == "#{input_}".to_i}[1]
      #occurs = []
      #@@all.each do |event|
      #  if event.title.include? (event_hash.detect {|k,v| v.include?("#{input}") || k == "#{input}".to_i}[1][0])
      #    occurs << event
      #  end #if statement
      #end # all each end
      #@@all.each do |k,v| #needs to match the detected exhibit type name
        #if k.include? (current_hash.detect {|k,v| v.include?("#{input}") || k == "#{input}".to_i}[1])
      #returns list of first 20 events
        #if v.size >= 20 #v is an array of Event Objects
        #  split_array = v.each_slice(20).to_a
        #  split_array[@@counter].each.with_index(1) do |event_obj,i|
        #    puts "#{i}. #{event_obj.title} (#{event_obj.type.name})"
        #  end #split_array each
        #else
        #  v.each {|event_object| puts "#{@@counter += 1}. #{event_object.title}"}
        #end #v.size this returns a 20 item list
    #end #all each statement
  #end #if statement
      #if a_hash.detect {|k,v| v.include?("#{input_1}") || k == "#{input_1}".to_i}
      #  sleep(0.5) #returns event details--sends users over to Event
      #  Aic::Event.event_info(a_hash, input_1)
    #  elsif input_1 == "more" #reveals next 20 events
        #  @@counter += 1
        #  event_list
      #elsif a_hash.none? {|k,v| v.include?("#{input_1}") || k == "#{input_1}".to_i}
          #sleep(0.5)
        #  puts "Sorry! I can't find that event."
        #  event_list
    #  end #big if statement
  end

  def self.events_partial #just generates list of 20 events
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
        end #v.size this returns a 20 item list
      end #if statement k.include?
    end #all each statement
  end #20_events

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
