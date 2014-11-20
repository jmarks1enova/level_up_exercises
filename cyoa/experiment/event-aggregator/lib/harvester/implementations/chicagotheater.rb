module Harvester
  module ChicagoTheater
  # open url
  # look for a.detailhead
  # Collect text between subordinate <strong> tags -  That's title
  # Collect href target - that's details page
  # Find span.redbody
  # Collect text - That's performer
  # Find immediate sibling <a>
  # Collect text - That's venue
  # Skip next container <tr>
  # Find td.body
  # Collect text - That's description
  # Find img src=images/main/spacer.gif
  # That's end of event summary
  # Jump to details page
  # find table.daysTable
  # For each row:
  #   Capture text of first <td> - That's Date
  #   Capture text of 2nd <td> - That's time

    class MainPageScraper < Harvester::HtmlScraper::HtmlScraperStrategy
      attr_reader :event_page_url

      # Links to event pages are found as href in:
      # <a href="..." class="detailhead">...</a>
      def start_element(name, attrs)
        return unless name == 'a' && attrs['class'] = 'detailhead'
        @event_page_url = attrs['href']
        collect_event_information
      end

      private

      def collect_event_information
        detail_harvester.run(html_scraper.event_producer)
      end

      def detail_harvester
        detail_scraper = DetailPageScraper.new(html_scraper)
        Harvester::HtmlScraper.new(event_page_url, detail_scraper)
      end
    end

    class DetailPageScraper < Harvester::HtmlScraper::HtmlScraperStrategy
      def start_element(name, attrs)

      end

      def finish
        event_producer.yield_event
      end
    end
  end
end
