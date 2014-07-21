class AddHomeworkIdToProblems < ActiveRecord::Migration
  def change
  	add_column :problems, :homework_id, :integer
  end
end
