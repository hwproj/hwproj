class AddSubmissionsIndexToTaskId < ActiveRecord::Migration
  def change
  	add_index :submissions, :task_id
  end
end
