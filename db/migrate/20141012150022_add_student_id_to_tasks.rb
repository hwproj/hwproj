class AddStudentIdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :student_id, :integer
  end
end
