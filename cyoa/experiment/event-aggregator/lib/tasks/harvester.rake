namespace :harvester do
  desc "Collect data from Opening Night Calendar"
  task test: :environment do

    require "harvester/rss_import"

    url = "http://www.theatreinchicago.com/news/TICrss.xml"
    
    harvester = Harvester::RSSFeedHarvester.new
    harvester.create_calendar_items_from(url) # do |harvester, item|
    #
    # end
  end

end
