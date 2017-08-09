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

    when "future"
      puts "1. Color Studies"
      puts "2. Making Memories: Quilts as Souvenirs"
      puts "Enter the name of the exhibit or its number for dates, times, and description"
    end #case statements end
  end #exhibits end

  def events
    puts "To see a list of all events in the next year, type 'all'"
    puts "Enter a start and end date (MM/DD/YYYY) to see events during that time"
    puts "To see certain types of events, enter 'type'"
  end #events end

  def info
    puts "Hours: 10:30am - 5pm"
    puts "Location: 111 South Michigan Avenue"
    puts "Admission fees are based in part on state and city residency.
    Please select one of the following to see full admission costs
    (note that this does not include Fast Passes, Memberships, or combination tickets"
  end #info end

  def selection

  end
end#CLI object end
