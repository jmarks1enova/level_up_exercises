require "open-uri"
require "rss"

module Harvester
  class RSSFeedHarvester
    attr_accessor :tags, :source, :callback_on_error
    attr_reader :feed_title, :feed_description, :url

    FEED_TYPE = 'application/rss+xml'

    DEFAULT_ITEM_TRANSFORM = ->(_harvester, _item) { true }

    DEFAULT_CALLBACK_ON_ERROR = ->(exception, harvester, rss_item) do
      $stderr.printf("%s harvester error [%s]: %s", class.name,
                     exception.class.name, exception.message)
    end
      
    EVENT_TO_RSS_ITEM_FIELD =
    {
      title:        title,
      description:  description,
      start_time:   start_time
    }

    def initialize(options = {})
      @source = options[:source]
      @tags = options.fetch(:tags, [])
      @callback_on_error =
        options.fetch(:callback_on_error, DEFAULT_CALLBACK_ON_ERROR)
    end

    def create_calendar_items_from(url, &block)
      @url = url
      block ||= DEFAULT_ITEM_TRANSFORM
      open(url) { |feed| process_rss_feed(feed, block) }
    end

    private

    def process_rss_feed(feed, block)
      initialize_processing_state(feed)

      feed.items.each do |item|
        populate_calendar(item) if block.call(self, item)
      end
    end

    def initialize_processing_state(feed)
      @feed = feed
      @feed_title = feed.channel.title
      @feed_description = feed.channel.description
      @source = construct_calendar_event_source
    end

    def construct_calendar_event_source
      EventSource.where(url: url)
    end

    def populate_calendar(rss_item)
      event = CalendarEvent.new(event_construction_params_from_rss(rss_item))
      associate_event_tags(event, rss_item)
      # event_attachments?? DO WE NEED THESE??
      event FIXME
    rescue RuntimeError => err
      callback_on_error.(err, self, rss_item)
    end

    def event_construction_params_from_rss(rss_item)
      param_list = EVENT_TO_RSS_ITEM_FIELD.each_pair.map do |event, rss|
        rss_field_value = rss_item.send(:rss)
        [event, rss_field_value] unless rss_field_value.nil?
      end
      param_list << [:source, source]
      Hash[param_list.compact]
    end
  end
end
