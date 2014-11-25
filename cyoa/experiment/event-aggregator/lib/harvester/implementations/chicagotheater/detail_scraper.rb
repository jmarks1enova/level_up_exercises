require "chronic"

module Harvester
  class DetailPageScraper 
    include Harvester::HtmlScraper::HtmlScraperStrategy
    
    def run
      extract_event_information
      create_event_family
    end

    private

    def extract_event_information
      new_event_attributes.merge({
        title: html_node_text("#titleP strong.detailhead"),
        location: html_node_text("#theatreName a"),
        description: html_node_text("#theatreName + p + p"),
        host: find_presenter,
      })
      enumerate_event_times
    end

    def create_event

    end

    def html_node_text(css_selector, root = document)
      document.css(css_selector).first.text.strip
    rescue
      nil
    end

    def find_presenter
      find_node_text("#theatreName + p + p + span", /(?<=Presented by )(.*)/)
    end

    def find_thru_date
      selector = "table table table p.detailbody.bottomPad"
      find_node_text(selector, /(?<=Thru - )(.*)/)
    end

    def find_node_text(css, pattern, root = document)
      root.css(css).first.traverse do |node|
        (match, _waste) = *node.text.match(pattern)
        return match if match
      end
      nil
    end

    def enumerate_event_times
      @thru_date = find_thru_date
      times = extract_event_times.map { |time| convert_to_time(time) }
      @event_times = times.flatten.compact
    end

    def extract_event_times
      times = document.css("table.daysTable tr").map do |node|
        node.css("td").map { |td| td.text.strip }.join(" ")
      end
      times.reject { |t| t.empty? }
    end

    def convert_to_time(time)
      Chronic.parse(time)
    end
  end
end
