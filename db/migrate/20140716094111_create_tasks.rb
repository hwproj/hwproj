class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :number
      t.string :problem

      t.timestamps
    end
  end
end
