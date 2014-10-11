class AddStudentIdToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :student_id, :integer
  end
end
