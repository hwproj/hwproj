class AddStudentIdAndStatusIndexToTasks < ActiveRecord::Migration
  def change
    add_index :tasks, [ :user_id, :status ]
  end
end
