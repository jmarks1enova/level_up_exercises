module Harvester
  class EventProducer

    DEFAULT_CALLBACK_ON_YIELD = ->(_harvester, event) { event.save }

    attr_reader :event_data_context, :current_event
    attr_accessor :event_source

    def initialize
      setup_processing_context(nil)
    end

    def create_calendar_items_from(data_collector, &block)
      @callback_on_create = block || DEFAULT_CALLBACK_ON_YIELD
      setup_processing_context(data_collector)
      data_collector.run(self)
    end

    def event_source
      @event_source ||= data_collector.event_source
    end

    def yield_event
      event = CalendarEvent.new(new_event_attributes)
      yield event if block_given?
      @callback_on_create.call(current_event)
    end

    def self.create_calendar_items_from(data_collector, &block)
      new.create_calendar_items_from(data_collector, &block)
    end

    private

    def setup_processing_context(data_collector)
      @data_collector = data_collector
      @event_data_context = { event_attributes: {} }
      @current_event = {}
    end

    def new_event_attributes
      event_data_context[:event_attributes].merge({ source: event_source })
    end
  end
end
