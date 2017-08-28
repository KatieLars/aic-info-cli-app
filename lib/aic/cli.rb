require 'pry'
require 'chronic'
require 'nokogiri'
require 'open-uri'

class Aic::CLI

  def call #COMPLETE
    menu
    input = gets.strip
    case input
    when "exhibitions"
      exhibitions
    when "events"
      events
    when "info"
      info
    else
      call
    end #case statement end
  end #call end


  def menu #COMPLETE
    puts "Come see what's at the Art Institute!"
    puts "For current and upcoming exhibitions, type 'exhibitions'"
    puts "For upcoming events, type 'events'"
    puts "For general information, such as hours and admissions, type 'info'"
  end #menu end

  def exhibitions #COMPLETE
    puts "For current exhibitions, enter 'current'"
    puts "For upcoming exhibitions, enter 'upcoming'"
    input = gets.strip
    if input == "current" || input == "upcoming"
      Aic::Exhibition.scrape_from_web("http://www.artic.edu/exhibitions/#{input}")
      Aic::Exhibition.exhibit_info("#{input}")
    else
      exhibitions
    end
  end #exhibits end

  def events
    puts "To see a list of all events in the next month, type 'all'"
    puts "Enter a date(MM/DD/YYYY) or type 'range' to enter a date range and see select events"
    puts "To see certain types of events, enter 'type'"
    doc = Nokogiri::HTML(open("http://www.artic.edu/calendar?date1=08-26-2017&date2=09-26-2017"))
    event_array = doc.css("div.calendar_result div.views-row")
    binding.pry
    input = gets.strip
    case input
    when "all" #returns list of scraped events for the next month
      date1 = Time.now
      date2 = Chronic.parse("one month from #{date1}")
      Aic::Events.scrape_from_web("http://www.artic.edu/calendar?date1=#{date1.strftime("%m-%d-%Y")}&date2=#{date2.strftime("%m-%d-%Y")}")
      #returns a list (title and type) of events falling between this array
      puts "Enter the name of the event or its number for dates, times, and description"
      new_input = gets.strip
      selection(new_input)
    when Chronic.parse(input).is_a?(Time) #create a date method?
      #accesses Aic:: EventDate class
      puts "First Selection"
      #eventually will run event_date_comparison(input)
      puts "Enter the name of the event or its number for dates, times, and description"
      new_input = gets.strip
      selection(new_input)
    when "range" #create a range method?
      #accesses Aic::EventDate class
      puts "Please enter a start date (MM/DD/YYYY)"
      start_date = gets.strip
      puts "Please enter an end date (MM/DD/YYYY)"
      end_date = gets.strip
      #eventually will run event_date_comparison(start_date, end_date)
      puts "Enter the name of the event or its number for dates, times, and description"
      new_input = gets.strip
      selection(new_input)
    when "type"
      #accesses Aic::EventType
      puts "Enter the name of the event or its number for dates, times, and description"
      new_input = gets.strip
      selection(new_input)
    end #case statement end
  end #events end

  def info
    puts "Hours: 10:30am - 5pm"
    puts "Location: 111 South Michigan Avenue"
    puts "Admission fees are based in part on state and city residency.
    Please select one of the following to see full admission costs:
    (note that this does not include Fast Passes, Memberships, or combination tickets)" #consider using a here doc
    admission
  end #info end

    def selection(choice) #selects the name of an Event or the integer indicating its title, and returns Event info
      #EventType.all.each do |k,v| #iterates over a hash and returns Type.events.title for correct type
      # if input == k.name #if input matches name of EventType
         #events_array = k.events.collect {|e| e.title} #returns array of event titles
         #events_array.each.with_index(1) {|i, e| puts "#{i}. #{e}\n"
        #end #if statement end
        #if input.to_i.is_a?(Integer) matches number to correct type and produces list of events for that type
          #y = type_menu.each {|string| string.include?(input)} checking array for numbers, returns string
          #x = y.split
          #EventType.each do |type_instance|
            #puts "#{type_instance.name.include?(x[1]).events}" #returns the events list from the type instance that includes
          #end #each statement end
        #end #if statement end
      #end #all.each end
      if choice.to_i.is_a?(Integer)
        puts "First selection"
      #elsif choice matches any of the names of exhibits/events,
        #return all the info (title, dates, location, url, description, type, etc.)
      else
        puts "Second selection"
      end #if end
    end#selection end

    def event_date_comparison(start_date, end_date = 0) #accepts a string of numbers (MM/DD/YYY) and returns them as a Time object
      start = Chronic.parse(start_date)
      if end_date != 0
        over = Chronic.parse(end_date)
      end #if statement end
      #lists Event.title where all Event.date == start
      #lists Event.title where all Event.date.between?(start, over)
    end #event_date_comparison end

    def type
      puts "Please choose from one of the following categories, entering either the name or number:"
      #counter = 1
      #type_menu = []
      #Event.all.each do |k,v| #creates type_menu array and puts list of options
        #type_menu << "#{counter +1}. #{k}"
        #puts "#{counter +1}. #{k}\n"
        #counter += 1
      #end #each end
      #type_menu
        #@@all is a hash with types being the keys, and number of events of each type, the values. Sorted with high values first.
      input = gets.strip #input must match menu option (number or words) and then puts a list of all the events in that type
        #EventType.all.each do |k,v| #iterates over a hash and returns Type.events.title for correct type
        # if input == k.name #if input matches name of EventType
           #events_array = k.events.collect {|e| e.title} #returns array of event titles
           #events_array.each.with_index(1) {|i, e| puts "#{i}. #{e}\n"
          #end #if statement end
          #if input.to_i.is_a?(Integer) matches number to correct type and produces list of events for that type
            #y = type_menu.each {|string| string.include?(input)} checking array for numbers, returns string
            #x = y.split
            #EventType.each do |type_instance|
              #puts "#{type_instance.name.include?(x[1]).events}" #returns the events list from the type instance that includes
            #end #each statement end
          #end #if statement end
        #end #all.each end
      #returns a list of all events names of that type
    end #type end

    def admission
      admission_list = ["1. General", "2. Illinois", "3. Chicago", "4. Free"]
      admission_list.each {|e| puts "#{e}\n"}
      input = gets.strip
      if admission_list.each {|e| e.include?(input)} #if input maches one of the admission_list options
        z = admission_list.select {|e| e.include?(input)}.join.split[1] #returns string without integer ("Illinois")
        #Scraper.send("scrape_admission", "#{z}")
        #takes the string result of z, and #sends it to the Scraper method #scrape_admission with an argument of z
      else
        admission
      end #if statment end
    end #admission end
end#CLI object end
