class AddUserIdProblemIdToTasks < ActiveRecord::Migration
  def change
  	add_column :tasks, :user_id, :integer
  	add_column :tasks, :problem_id, :integer
  end
end
