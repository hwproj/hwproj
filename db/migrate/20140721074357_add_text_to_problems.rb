class AddTextToProblems < ActiveRecord::Migration
  def change
  	add_column :problems, :text, :string
  end
end
