class RemoveHomeworkIdNumberFromTasks < ActiveRecord::Migration
  def change
  	remove_column :tasks, :homework_id, :integer
  	remove_column :tasks, :number, :integer
  end
end
