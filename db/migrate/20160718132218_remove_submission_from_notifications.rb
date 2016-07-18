class RemoveSubmissionFromNotifications < ActiveRecord::Migration
  def change
    remove_column :notifications, :submission_id
  end
end
