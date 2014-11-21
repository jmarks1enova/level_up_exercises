require "uri"

module Harvester
  module ChicagoTheater
    class MainPageScraper
      include Harvester::HtmlScraper::HtmlScraperStrategy

      # Links to event pages are found as href in:
      # <a href="..." class="detailhead">...</a>
      def run
        event_links.each { |link| collect_event_information(link) }
      end
         
      private

      def event_links
        document.css('a.detailhead').map { |link| URI.join(uri, link['href']) }
      end

      def collect_event_information(event_uri)
        detail_harvester(event_uri).run(html_scraper.event_producer)
      end

      def detail_harvester(event_uri)
        detail_scraper = DetailPageScraper.new
        Harvester::HtmlScraper.new(event_uri, detail_scraper)
      end
    end

    class DetailPageScraper 
      include Harvester::HtmlScraper::HtmlScraperStrategy
      
      def run
        $stderr.puts "DETAIL HARVESTING URI #{uri}"

        title = html_node_text("#titleP strong.detailhead")
        $stderr.puts "DETAIL TITLE #{title}"
        theater = html_node_text("#theatreName a")
        $stderr.puts "DETAIL THEATRE: #{theater}"
        description = html_node_text("#theatreName + p + p")
        $stderr.puts "DETAIL DESC: #{description}"
        presenter = find_presenter
        $stderr.puts "DETAIL PRESENTER: #{presenter}"
        times = enumerate_event_times 
        times.each { |t| $stderr.puts "   TIME: #{t}" }
      end

      private

      def html_node_text(css_selector, root = document)
        document.css(css_selector).first.text.strip
      rescue
        nil
      end

      def find_presenter
        document.css("#theatreName + p + p + span").first.traverse do |node|
          (_m, presenter) = *node.text.match(/Presented by (.*)\s*/)
          return presenter if presenter
        end
        nil
      end

      def find_node_text(css, pattern, root = document)
        root.css(css).first.traverse do |node|
          (match, _waste) = *node.text.match(pattern)
          return match if match
        end
        nil
      end

      def enumerate_event_times
        extract_event_times.map { |time| convert_to_times }.flatten.compact
      end

      def extract_event_times
        times = document.css("table.daysTable tr").map do |node|
          node.css("td").map { |td| td.text.strip }.join(" ")
        end
        times.reject { |t| t.empty? }
      end
    end
  end
end
