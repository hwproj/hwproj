class AddNumberToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :number, :integer
  end
end
