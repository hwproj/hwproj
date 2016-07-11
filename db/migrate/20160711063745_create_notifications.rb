class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :submission, index: true
      t.references :task, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
