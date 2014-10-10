class SetApprovedDefaultToStudents < ActiveRecord::Migration
  def change
    change_column :students, :approved, :boolean, default: false
  end
end
