class AddIsReadToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :is_read, :boolean, default: false
  end
end
