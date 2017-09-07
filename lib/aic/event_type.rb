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

  def self.select_type # generates a list of types for specified date range
    type_hash = Hash.new
    @@all.to_a.each.with_index(1) {|e,i| type_hash[i] = "#{e[0]}"}
    type_hash.each {|k,v| puts "#{k}. #{v}"}
    puts "Select the number of the event to see a list of all that type of event"
    input = gets.strip
    event_list(input)
  end

  def self.event_list(input) #lists events based on type
    sleep(0.5)
    current_hash = Hash.new
    select_event_hash = Hash.new #an array of all Event objects corresponding to selected type
    @@all.to_a.each.with_index(1) {|e,i| current_hash[i] = "#{e[0]}"}
        @@all.each do |k,v| #needs to match the detected type name or
          if k.detect (current_hash.detect {|k,v| v.include?("#{input}") || k == "#{input}".to_i}[1])
            #k.include? may be a problem here . . .Family program and Talk appears in different types of events
        #returns list of first 20 events
            v.each.with_index(1) {|e_obj, i| select_event_hash[i] = e_obj} #making select_event_hash
            unique_array = []
            v.each do |e| #v is an array of Event Objects
              if !unique_array.include?("#{e.title}")
                unique_array << e.title
              end #if unique_array.include?
            end #v.each do
            if unique_array.size >= 20
              unique_hash = {}
              unique_array.each.with_index(1) {|e,i| unique_hash[i] = e}
              nested_arrays = unique_hash.to_a.each_slice(20).to_a #nested array where each element is an array of 20 elements
              nested_arrays[@@counter].each do |small_e|
                puts "#{small_e[0]}. #{small_e[1]}"
              binding.pry
              end #nested_arrays

            else
            unique_array.each.with_index(1) {|eventini, i| puts "#{i}. #{eventini}"}
            end #v.size this returns a 20 item list
          end #k.include?
        end #all.each statement
      puts "Enter an event name or number for dates, times, and description."
      puts "Or enter 'more' to see the next 20 events."
      input_1 = gets.strip
      if input_1 == "more"
        @@counter += 1
        event_list(input)
      elsif select_event_hash.none? {|k,v| v.title.include?("#{input_1}") || k == "#{input_1}".to_i}
          puts "Sorry! I can't find that event."
          sleep(1.0)
          event_list(input)
      else
        event_details(select_event_hash, input_1)
     #events of the select type
      end #more input
  end #event_list
#remember that@@all points to an array (v is an array)
  def self.event_details(a_hash, input) #generates details for list or next 20 in list
      sleep(0.5)
      if a_hash.detect {|k,v|  v.title.include?("#{input}") || k == "#{input}".to_i}
        #input matches presented event options
        #need to take out all events matching that input
        found_events = [] #array of all events fitting input
        x =  a_hash.detect {|k,v|  v.title.include?("#{input}") || k == "#{input}".to_i}[1].title
        #x is event title to match to all objects
        if a_hash.detect {|k,v|  v.title.include?("#{x}")}
          z = a_hash.select {|k,v|  v.title.include?("#{x}")}
          #z is a hash of relevant events
          z.each {|k,v| found_events << v}
          puts "#{found_events[0].title}"
          puts "#{found_events[0].type.name}"
          puts "#{found_events[0].description}"
          puts "When:"
          found_events.each do |e|
            puts "#{e.date.strftime("%m-%d-%Y")}"
            puts "#{e.time}"
            puts "#{e.url}"
            puts ""
          end #found_events
        end #a_hash detect
        elsif a_hash.none? {|k,v| v.include?("#{input_1}") || k == "#{input_1}".to_i}
          sleep(0.5)
            puts "Sorry! I can't find that event."
      end #if statement
  end

  #EventTypes have: a list of all Event objects that correspond to them. They also have names generated from a scraper
  #@@all is a hash that keeps track of how many of each Event type there is. Keys are EventType objects and values are the number of that type.
  #Types should only be added to EventType iff there isn't already one present in the hash. Otherwise, the values for the
    #appropriate key should tick up one.
  #Control for type: events should always be Event objects

end
