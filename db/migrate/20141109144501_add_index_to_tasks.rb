class AddIndexToTasks < ActiveRecord::Migration
  def change
    add_index :tasks, :problem_id
  end
end
