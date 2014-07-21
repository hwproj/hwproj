class AddDefaultUserTypeToUsers < ActiveRecord::Migration
  def change
  	change_column :users, :user_type, :integer, default: 0
  end
end
