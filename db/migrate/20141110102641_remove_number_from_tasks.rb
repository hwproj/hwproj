class RemoveNumberFromTasks < ActiveRecord::Migration
  def change
    remove_column :tasks, :number
  end
end
