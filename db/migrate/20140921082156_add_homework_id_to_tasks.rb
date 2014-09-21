class AddHomeworkIdToTasks < ActiveRecord::Migration
  def change
  	add_column :tasks, :homework_id, :integer
  end
end
