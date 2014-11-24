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

    require "harvester"
    require "harvester/implementations/chicagotheater"

    url = "http://www.theatreinchicago.com/nowplayingrs.php"
    
    strategy = Harvester::ChicagoTheater::MainPageScraper.new
    harvester = Harvester::HtmlScraper.new(url, strategy, set_event_source: true)
    Harvester::EventProducer.create_calendar_items_from(harvester) # do |harvester, event|
      # Return true to save the event
    # end
  end
end
