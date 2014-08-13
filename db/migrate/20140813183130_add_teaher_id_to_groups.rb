class AddTeaherIdToGroups < ActiveRecord::Migration
  def change
  	add_column :groups, :teacher_id, :integer
  end
end
