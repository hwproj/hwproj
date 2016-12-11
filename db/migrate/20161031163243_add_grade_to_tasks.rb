class AddGradeToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :grade, :integer, default: 0, null: false
    reversible do |dir|
      dir.up { Task.where(status: Task.statuses[:accepted], grade: 0).update_all(grade: 1) }
    end
  end
end
