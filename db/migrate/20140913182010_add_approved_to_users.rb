class AddApprovedToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :approved, :boolean, default: 0
  end
end
