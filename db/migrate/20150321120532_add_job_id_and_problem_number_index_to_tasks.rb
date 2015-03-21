class AddJobIdAndProblemNumberIndexToTasks < ActiveRecord::Migration
  def change
  	add_index :tasks, [ :job_id, :problem_number ]
  end
end
