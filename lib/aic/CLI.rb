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
    when "all" #returns list of scraped events
      puts "1. The Artist's Studio (Family Program)"
      puts "2. Gallery Talk: Gauguin's Circle (Talk)"
    when Chronic.parse(input).is_a?(Time) && !input.include?("-")#returns events on a single date
      puts "First Selection"
    when "range"
      puts "Please enter a start date (MM/DD/YYYY)"
      start_date = gets.strip
      puts "Please enter an end date (MM/DD/YYYY)"
      end_date = gets.strip
      date_conversion(start_date, end_date)
    when
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

    def date_conversion(start_date, end_date) #accepts a string of numbers (MM/DD/YYY) and returns them as a Time object
      start = Chronic.parse(start_date)
      over = Chronic.parse(end_date)
      end#ends if statement
    end #date_conversion end
end#CLI object end
