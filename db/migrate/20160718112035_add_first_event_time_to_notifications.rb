class AddFirstEventTimeToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :first_event_time, :datetime
  end
end
