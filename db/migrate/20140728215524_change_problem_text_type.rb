class ChangeProblemTextType < ActiveRecord::Migration
  def change
  	change_column :problems, :text, :text
  end
end
