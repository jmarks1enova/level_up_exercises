require "nokogiri"
require "open-uri"

require "harvester/html_scraper_strategy"

module Harvester
  class HtmlScraper
    attr_reader :collection_strategy, :event_producer, :uri, :document
    attr_accessor :current_state, :set_event_source

    def initialize(uri, collection_strategy, opts = {})
      @uri = uri
      @event_producer = nil
      @collection_strategy = collection_strategy
      @set_event_source = opts.fetch(:set_event_source, false)
    end

    def run(event_producer)
      @event_producer = event_producer
      setup_processing_context
      collection_strategy.run
    end

    private

    def setup_processing_context
      @document = Nokogiri::HTML(open(uri), uri.to_s)
      event_producer.event_source = :uri if @set_event_source
      collection_strategy.initialize_collection(self)
    end
  end
end


