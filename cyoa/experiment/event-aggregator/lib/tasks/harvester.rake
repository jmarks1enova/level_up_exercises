namespace :harvester do
  desc "Collect data from event sources"
  task test: :environment do

    require "harvester/rss_import"

    url = "http://www.theatreinchicago.com/news/TICrss.xml"
    
    harvester = Harvester::RSSFeedHarvester.new
    harvester.create_calendar_items_from(url) # do |harvester, item, event|
    #
    # end
  end

  task htmltest: :environment do

    url = "http://www.theatreinchicago.com/nowplayingrs.php"
    
    harvester = Harvester::HtmlScraper.new
    harvester.create_calendar_items_from(url) # do |harvester, event|
      # Return true to save the event
    # end
  end
end
