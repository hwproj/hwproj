class AddIndicesToJobsAndTasks < ActiveRecord::Migration
  def change
    add_index :jobs, :student_id
    add_index :tasks, :job_id
  end
end
