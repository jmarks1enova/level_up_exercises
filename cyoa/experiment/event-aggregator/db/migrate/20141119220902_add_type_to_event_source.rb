class AddTypeToEventSource < ActiveRecord::Migration
  def change
    add_column :event_sources, :type, :string
  end
end
