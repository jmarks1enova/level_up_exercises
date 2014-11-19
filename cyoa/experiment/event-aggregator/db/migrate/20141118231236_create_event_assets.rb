class CreateEventAssets < ActiveRecord::Migration
  def change
    create_table :event_assets do |t|
      t.integer :calendar_event_id
      t.string :caption
      t.string :mime_type
      t.binary :data

      t.timestamps
    end
  end
end
