class AddTeacherIdToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :teacher_id, :integer
  end
end
