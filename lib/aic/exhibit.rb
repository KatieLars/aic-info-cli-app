class Aic::Exhibition
  attr_accessor :title, :date_range, :url, :description, :location
  @@current = []
  @@upcoming = []

  def self.scrape_from_web(url) #scrapes creates Exhibit objects from either upcoming or current website
    doc = Nokogiri::HTML(open("#{url}"))
    exhibit_array = doc.css("div.view.view-exhibitions div.views-row")
    exhibit_array.each do |xml_element|
      new_exhibit = Aic::Exhibition.new
      new_exhibit.title = xml_element.css("div.views-field.views-field-title span.field-content").text.tr("\n", "")
      new_exhibit.date_range = xml_element.css("strong.views-field.views-field-field-event-date div.field-content").text
      new_exhibit.location = xml_element.css("div.views-field.views-field-field-exhibition-room div.field-content").text
      new_exhibit.description = xml_element.css("div.views-field.views-field-body span.field-content").first.text.strip
      new_exhibit.url = "http://www.artic.edu" + xml_element.css("div.views-field.views-field-title span.field-content a").attribute("href").text
      if url.include?("current")
        @@current << new_exhibit
      elsif url.include?("upcoming")
        @@upcoming << new_exhibit
      end #if/else
    end #each
  end #scrape_from_web

  def self.exhibit_info(type) #generates exhibit info depending on user input
    current_hash = {}
    unique_hash = {}
    send("#{type}").each.with_index(1) {|e, i| current_hash[i] =  "#{e.title}"}
    x = current_hash.to_a.uniq {|e| e[1]}
    x.each do |pair|
      puts "#{pair[0]}. #{pair[1]}"
      unique_hash[pair[0]] = "#{pair[1]}"
    end
    puts "Enter the name of the exhibition or its number for dates, times, and description"
    new_input = gets.strip
    if unique_hash.detect {|k,v| v.include?("#{new_input}") || k == "#{new_input}".to_i}
      send("#{type}").uniq! {|e| e.title}
      send("#{type}").each do |exhibit|
        if exhibit.title.include? (unique_hash.detect {|k,v| v.include?("#{new_input}") || k == "#{new_input}".to_i}[1])
          sleep(1.0)
          puts "#{exhibit.title}"
          puts "#{exhibit.date_range}"
          puts "#{exhibit.location}"
          puts "#{exhibit.description}"
          puts "#{exhibit.url}"
        end #inner if statement must stay
      end #each end
    elsif unique_hash.none? {|k,v| v.include?("#{new_input}") || k == "#{new_input}".to_i}
       sleep(0.5)
       puts "Sorry! I can't find that exhibition."
       exhibit_info(type)
     end #outer if statement
  end #exhibit_info

  def self.current #returns array of current Exhibit objects
    @@current
  end

  def self.upcoming
    @@upcoming
  end

end
