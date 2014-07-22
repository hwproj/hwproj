class AddNumberToProblems < ActiveRecord::Migration
  def change
  	add_column :problems, :number, :integer
  end
end
