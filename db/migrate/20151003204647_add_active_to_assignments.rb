class AddActiveToAssignments < ActiveRecord::Migration
  def change
  	add_column :homeworks, :active, :boolean, default: true
  end
end
