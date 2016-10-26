class SetActiveDefaultToStudents < ActiveRecord::Migration
  def change
    change_column :students, :active, :boolean, default: true
  end
end
