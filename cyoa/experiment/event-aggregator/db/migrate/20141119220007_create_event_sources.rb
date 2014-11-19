class CreateEventSources < ActiveRecord::Migration
  def change
    create_table :event_sources do |t|
      t.string :name
      t.string :url
      t.integer :frequency
      t.integer :last_harvest
      t.text :json_parameters

      t.timestamps
    end
  end
end
