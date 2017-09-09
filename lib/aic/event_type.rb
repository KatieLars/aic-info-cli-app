class Aic::EventType #HAS MANY Events
  attr_accessor :name, :events
  @@all = Hash.new(v = @events)
  @@counter = 0

  def initialize(name)
    @events = []
    if name != ""
      @name = name
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
    puts "Select the number of the event type or enter the type name to see a list of all relevant events"
    input = gets.strip
    if type_hash.detect {|k,v| v == "#{input}" || k == "#{input}".to_i}
      event_list(input)
    else
      puts"Sorry! I couldn't find that type of event."
      select_type
    end
  end

  def self.event_list(input)
    orig_in = input #lists events based on type
    sleep(0.5)
    current_hash = Hash.new
    select_event_hash = Hash.new
    unique_hash = {}
    @@all.to_a.each.with_index(1) {|e,i| current_hash[i] = "#{e[0]}"}
    if current_hash.detect {|k,v| v == "#{input}" || k == "#{input}".to_i}
        @@all.each do |k,v|
          if k == current_hash.detect {|k,v| v == "#{input}" || k == "#{input}".to_i}[1]
          v.each.with_index(1) {|e_obj, i| select_event_hash[i] = e_obj}
          unique_array = []
          v.each do |e|
            if !unique_array.include?("#{e.title}")
              unique_array << e.title
            end #if unique_array.include?
          end #v.each do
            if unique_array.size >= 20
              unique_array.each.with_index(1) {|e,i| unique_hash[i] = e}
              nested_arrays = unique_hash.to_a.each_slice(20).to_a #nested array where each element is an array of 20 elements
              nested_arrays[@@counter].each {|small_e| puts "#{small_e[0]}. #{small_e[1]}"}
            else
            unique_array.each.with_index(1) {|e,i| unique_hash[i] = e}
            unique_array.each.with_index(1) {|eventini, i| puts "#{i}. #{eventini}"}
            end #unique_array.size
          end #all.each
        end #k==
      end #current_hash statement
      puts "Enter an event name or number for dates, times, and description."
      puts "Or enter 'more' to see the next 20 events."
      input_1 = gets.strip
      if input_1 == "more"
        event_list(orig_in)
      elsif select_event_hash.none? {|k,v| v.title.include?("#{input_1}") || k == "#{input_1}".to_i}
        puts "Sorry! I can't find that event."
        sleep(1.0)
        event_list(orig_in)
      else
        event_details(unique_hash, select_event_hash, input_1)
      end
  end #event_list


  def self.event_details(unique_hash, all_hash, ip) #generates details for list or next 20 in list
      sleep(0.5)
      y = unique_hash.detect {|k,v| v == "#{ip}" || k == "#{ip}".to_i}[1]
      if all_hash.detect {|k,v|  v.title == "#{y}"}
        found_events = []
          z = all_hash.select {|k,v|  v.title == "#{y}"}
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
        elsif all_hash.none? {|k,v| v == "#{y}"}
          sleep(0.5)
          puts "Sorry! I can't find that event."
          event_list(input)
      end #if statement
  end


end
