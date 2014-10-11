class AddStudentIdToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :student_id, :integer
  end
end
