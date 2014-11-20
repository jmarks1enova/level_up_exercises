require "digest"

class CalendarEvent < ActiveRecord::Base
  belongs_to :event_source

  before_save :update_hash_code

  def update_hash_code
    hash_string = "#{source.name}#{title}#{start_time}#{end_time}"
    self.hash = Digest::SHA1.hexdigest(hash_string)
  end
end
