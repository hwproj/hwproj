class AddIndexToProblems < ActiveRecord::Migration
  def change
    add_index :problems, :homework_id
  end
end
