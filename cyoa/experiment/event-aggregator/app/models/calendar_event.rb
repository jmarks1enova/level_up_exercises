require "digest"

class CalendarEvent < ActiveRecord::Base
  belongs_to :event_source

  before_save :update_hash_codes

  def update_hash_codes
    self.family_hash = self.class.family_hash(self)
    self.event_hash = self.class.event_hash(self)
  end

  def self.family_hash_string(params)
    source_name = params.respond_to?(:event_source) ? params.event_source.name
                                                    : params[:event_source_name]
    "#{params[:source_name]}#{params[:title]}#{params[:location]}"
  end
  
  def self.family_hash(params)
    Digest::SHA1.hexdigest(family_hash_string(params))
  end

  def self.event_hash_string(params)
    family_hash = family_hash_string(params)
    "#{family_hash}#{params[:start_time].to_i}#{params[:end_time].to_i}"
  end

  def self.event_hash(params)
    Digest::SHA1.hexdigest(event_hash_string(params))
  end
end
