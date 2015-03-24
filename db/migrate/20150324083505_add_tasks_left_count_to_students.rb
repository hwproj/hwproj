class AddTasksLeftCountToStudents < ActiveRecord::Migration

  def self.up

    add_column :students, :tasks_left_count, :integer, :null => false, :default => 0

  end

  def self.down

    remove_column :students, :tasks_left_count

  end

end
