class AddProblemNumberToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :problem_number, :integer
  end
end
