class AddHashToCalendarEvent < ActiveRecord::Migration
  def change
    add_column :calendar_events, :hash, :string, limit: 64, null: false, default: "INVALID"
  end
end
