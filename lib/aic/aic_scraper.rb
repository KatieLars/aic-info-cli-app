class Aic::Scraper #I just scrape stuff. Scrip-scrap-scrape, and can see all other objects

  def self.scrape_admission(residency)
    case residency
    when "General"
      #scrapes code for General admission and re-organizes it
    when "Illinois"
      #scrapes code for Illinois residents and re-organizes it
    when "Chicago"
      #scrapes code for Chicago residents and re-organizes it
    when "Free"
      #scrapes code for free admission opportunities and re-organizes it
    end #case end
  end #general admission end

  
end
