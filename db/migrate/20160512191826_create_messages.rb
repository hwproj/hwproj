class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :text
      t.string :sender_name
      t.integer :task_id
      t.integer :user_id

      t.timestamps
    end
  end
end
