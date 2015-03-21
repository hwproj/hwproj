class AddProblemsIndexOnAssignmentIdAndId < ActiveRecord::Migration
  def change
  	add_index :problems, [ :homework_id, :id ]
  end
end
