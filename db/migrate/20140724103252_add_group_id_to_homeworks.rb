class AddGroupIdToHomeworks < ActiveRecord::Migration
  def change
  	add_column :homeworks, :group_id, :integer
  end
end
