class CreateCalendarEvents < ActiveRecord::Migration
  def change
    create_table :calendar_events do |t|
      t.string :title
      t.datetime :start_time
      t.string :end_time
      t.string :datetime
      t.text :description

      t.timestamps
    end
  end
end
