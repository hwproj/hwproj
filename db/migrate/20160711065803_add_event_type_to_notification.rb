class AddEventTypeToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :event_type, :integer
  end
end
