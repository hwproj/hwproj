class AddLastEventTimeToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :last_event_time, :datetime
  end
end
