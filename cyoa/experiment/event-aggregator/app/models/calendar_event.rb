require "digest"

class CalendarEvent < ActiveRecord::Base
  belongs_to :event_source

  before_save :update_hash_codes

  def update_hash_codes
    self.event_hash = Digest::SHA1.hexdigest(event_hash_string)
    self.family_hash = Digest::SHA1.hexdigest(family_hash_string)
  end

  private

  def family_hash_string
    "#{event_source.name}#{title}#{location}"
  end
  
  def event_hash_string
    "#{family_hash_string}#{start_time.to_i}#{end_time.to_i}"
  end
end
