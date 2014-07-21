class RemoveProblemFromTasks < ActiveRecord::Migration
  def change
  	remove_column :tasks, :problem, :string
  end
end
