require "nokogiri"

require "harvester/html_parser_adapter"

module Harvester
  class HtmlScraper
    attr_reader :collection_strategy, :event_producer, :url
    attr_accessor :current_state, :set_event_source

    def initialize(url, collection_strategy, opts = {})
      @url = url
      @collection_strategy = collection_strategy
      @parser = Nokogiri::HTML::SAX::Parser.new(HtmlParserAdapter.new(self))
      @set_source = opts.fetch(:set_event_source, false)
    end

    def run(event_producer)
      setup_processing_context(event_producer)
      @parser.parse(open(url))
      collection_strategy.finish
    end

    def start_element(name, attrs)
      current_state.start_element(name, attrs)
    end

    def end_element(name)
      current_state.end_element(name)
    end

    private

    def setup_processing_context(event_producer)
      @event_producer = event_producer
      self.current_state = collection_strategy
      collection_strategy.initialize_collection(self)
  end
end


