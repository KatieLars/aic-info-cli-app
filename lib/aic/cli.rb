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

  def events #needs refactoring #enter dates first, then see straight up list or organize by type
    puts "To see a list of the first twenty events in the next month, type 'all'"
    puts "Enter a date(MM/DD/YYYY) or type 'range' to enter a date range and see select events"
    puts "You may also enter 'today' to see today's events."
    #puts "To see certain types of events, enter 'type'"
    input = gets.strip
    case input
    when "all" #works
      puts "Enter 'type' to select events based on type (Talks, Screenings, etc.)"
      puts "Or type 'next' to see a list of events"
      date1 = Time.now
      date2 = Chronic.parse("one month from date1")
      Aic::Event.scrape_from_web("http://www.artic.edu/calendar?date1=#{date1.strftime("%m-%d-%Y")}&date2=#{date2.strftime("%m-%d-%Y")}")
      Aic::Event.type_or_next
    when "today" #works
      puts "Enter 'type' to select events based on type (Talks, Screenings, etc.)"
      puts "Or type 'next' to see a list of events"
      Aic::Event.scrape_from_web("http://www.artic.edu/calendar")
      Aic::Event.type_or_next
    when "Today"
      puts "Enter 'type' to select events based on type (Talks, Screenings, etc.)"
      puts "Or type 'next' to see a list of events"
      Aic::Event.scrape_from_web("http://www.artic.edu/calendar") #?date1=#{date1.strftime("%m-%d-%Y")}&date2=#{date1.strftime("%m-%d-%Y")}")
      Aic::Event.type_or_next
    #when (Chronic.parse("#{input}").is_a?(Time))#I want this to be a Time--more flexible
      #Chronic.parse("#{input}").is_a?(Time)
    #  date1 = Chronic.parse("#{input}")
    #  Aic::Event.scrape_from_web("http://www.artic.edu/calendar?date1=#{date1.strftime("%m-%d-%Y")}&date2=#{date1.strftime("%m-%d-%Y")}")
    #  Aic::Event.event_info
    when "range" #works
      puts "Please enter a start date (MM/DD/YYYY)"
      date1 = Chronic.parse("#{gets.strip}")
      puts "Please enter an end date (MM/DD/YYYY)"
      date2 = Chronic.parse("#{gets.strip}")
      puts "Enter 'type' to select events based on type (Talks, Screenings, etc.)"
      puts "Or type 'next' to see a list of events"
      Aic::Event.scrape_from_web("http://www.artic.edu/calendar?date1=#{date1.strftime("%m-%d-%Y")}&date2=#{date2.strftime("%m-%d-%Y")}")
      Aic::Event.type_or_next
  #  when "type" #display all events of a certain type for a specified date range
        #Aic::Event.scrape_from_web
      #accesses Aic::EventType
    end #case statement end
    if Chronic.parse("#{input}").is_a?(Time) && !input == "today" && !input == "Today"#works
      date1 = Chronic.parse("#{input}")
      puts "Enter 'type' to select events based on type (Talks, Screenings, etc.)"
      puts "Or type 'next' to see a list of events"
      Aic::Event.scrape_from_web("http://www.artic.edu/calendar?date1=#{date1.strftime("%m-%d-%Y")}&date2=#{date1.strftime("%m-%d-%Y")}")
      Aic::Event.type_or_next
    end
  end #events end

  def info
    puts "Hours: 10:30am - 5pm"
    puts "Location: 111 South Michigan Avenue"
    puts "Admission fees are based in part on state and city residency.
    Please select one of the following to see full admission costs:
    (note that this does not include Fast Passes, Memberships, or combination tickets)" #consider using a here doc
    admission
  end #info end

    def admission
      admission_list = ["1. General", "2. Illinois", "3. Chicago", "4. Free"]
      admission_list.each {|e| puts "#{e}\n"}
      input = gets.strip
      if admission_list.each {|e| e.include?("#{input}")} #if input maches one of the admission_list options
        z = admission_list.select {|e| e.include?("#{input}")}.join.split[1] #returns string without integer ("Illinois")
        Aic::Info.scrape_admission("#{z}")
        #Scraper.send("scrape_admission", "#{z}")
        #takes the string result of z, and #sends it to the Scraper method #scrape_admission with an argument of z
      else
        admission
      end #if statment end
    end #admission end
end#CLI object end
