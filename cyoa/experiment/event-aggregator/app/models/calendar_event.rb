require "digest"

class CalendarEvent < ActiveRecord::Base
  before_save :update_hash_code

  def update_hash_code
    self.hash = Digest::SHA1.hexdigest(source.name + title)
  end
end
