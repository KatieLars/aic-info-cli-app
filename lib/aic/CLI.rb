require 'pry'
require 'chronic'
class Aic::CLI

  def call
    menu
    input = gets.strip
    case input
    when "exhibits"
      exhibits
    when "events"
      events
    when "info"
      info
    else
      call
    end #case statement end
  end #call end


  def menu
    puts "Come see what's at the Art Institute!"
    puts "For current and upcoming exhibits, type 'exhibits'"
    puts "For upcoming events, type 'events'"
    puts "For general information, such as hours and admissions, type 'info'"
  end #menu end

  def exhibits
    puts "For current exhibits, enter 'current'"
    puts "For future exhibits, enter 'future'"
    input = gets.strip
    case input
    when "current"
      puts "1. Gauguin: Artist as Alchemist"
      puts "2. Saints and Heroes"
      puts "Enter the name of the exhibit or its number for dates, times, and description"
      new_input = gets.strip
      selection(new_input)
    when "future"
      puts "1. Color Studies"
      puts "2. Making Memories: Quilts as Souvenirs"
      puts "Enter the name of the exhibit or its number for dates, times, and description"
      new_input = gets.strip
      selection(new_input)
    end #case statements end
  end #exhibits end

  def events
    puts "To see a list of all events in the next year, type 'all'"
    puts "Enter a date or type 'range' to enter a date range and see select events"
    puts "To see certain types of events, enter 'type'"
    input = gets.strip
    case input
    when "all" #returns list of scraped events. Create an #all method?
      puts "1. The Artist's Studio (Family Program)"
      puts "2. Gallery Talk: Gauguin's Circle (Talk)"
      puts "Enter the name of the event or its number for dates, times, and description"
      new_input = gets.strip
      selection(new_input)
    when Chronic.parse(input).is_a?(Time) #create a date method?
      puts "First Selection"
      #eventually will run event_date_comparison(input)
      puts "Enter the name of the event or its number for dates, times, and description"
      new_input = gets.strip
      selection(new_input)
    when "range" #create a range method?
      puts "Please enter a start date (MM/DD/YYYY)"
      start_date = gets.strip
      puts "Please enter an end date (MM/DD/YYYY)"
      end_date = gets.strip
      #eventullly will run event_date_comparison(start_date, end_date)
      puts "Enter the name of the event or its number for dates, times, and description"
      new_input = gets.strip
      selection(new_input)
    when "type"
      #type
      puts "Enter the name of the event or its number for dates, times, and description"
      new_input = gets.strip
      selection(new_input
    end #case statement end
  end #events end

  def info
    puts "Hours: 10:30am - 5pm"
    puts "Location: 111 South Michigan Avenue"
    puts "Admission fees are based in part on state and city residency.
    Please select one of the following to see full admission costs
    (note that this does not include Fast Passes, Memberships, or combination tickets"
  end #info end

    def selection(choice)
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
      #Event.all.each.with_index(1) {|e, i| puts "#{i}. #{e}"} consider using a has for @@all to indicate the number of each
      #type and have @@all organized from the largest number to the smallest number
        #This will return a string

      #<< EVENT_TYPES
      #1. Talks
      #2. Member Exclusive
      #3. Family Program
      #4. Special Events
      #5. Live Arts
      #6. Classes and Workshops
      #7. Screenings
      #8. Misc (event does not fit into above categories)
      #EVENT_TYPES
      input = gets.strip
      case input
      when input.to_i.is_a?(Integer)
        #matches user input to the correct string
        #pulls revelent events from Event class
      when input
      #matches user input to Event.type
      #returns a list of all events names of that type
    end #type end

end#CLI object end
