class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.boolean :done, default: false
      t.integer :homework_id
      t.integer :user_id

      t.timestamps
    end
  end
end
