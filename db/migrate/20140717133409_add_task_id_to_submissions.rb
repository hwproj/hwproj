class AddTaskIdToSubmissions < ActiveRecord::Migration
  def change
  	add_column :submissions, :task_id, :integer
  end
end
