class Aic::CLI

  def call
    puts "Come see what's at the Art Institute!"
    puts "For current and upcoming exhibits, type 'exhibits'"
    puts "For upcoming events, type 'events'"
    puts "For general information, such as hours and admissions, type 'info'"
    input = gets.strip
    case input
    when "exhibits"
      puts "For current exhibits, enter 'current'"
      puts "For future exhibits, enter 'future'"
      #new_input = gets.strip
      #case new_input
      #when "current"
      #  puts "1. Gauguin: Artist as Alchemist"
      #  puts "2. Saints and Heroes"
      #when "future"
      #  puts "1. Color Studies"
      #  puts "2. Making Memories: Quilts as Souvenirs"
      #end
    when "events"
      puts "To see a list of all events in the next year, type 'all'"
      puts "Enter a start and end date (MM/DD/YYYY) to see events during that time"
      puts "To see certain types of events, enter one of the following"
      puts "<list of types scraped from event page>"
      puts
  end
end
