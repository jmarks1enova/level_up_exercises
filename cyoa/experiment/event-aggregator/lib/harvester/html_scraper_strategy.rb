module Harvester
  module HtmlScraper
    module HtmlScraperStrategy
      attr_accessor :html_scraper

      def initialize_collection(html_scraper)
        @html_scraper = html_scraper
      end

      def event_producer
        html_scraper.event_producer
      end

      def start_element(name, attrs)
        # Implemented for real in including classes
      end

      def end_element(name)
        # Implemented for real in including classes
      end

      def finish
        # Implemented for real in including classes
      end
    end
  end
end
