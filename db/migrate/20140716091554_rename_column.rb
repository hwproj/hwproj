class RenameColumn < ActiveRecord::Migration
  def change
  	rename_column :users, :type, :user_type
  end
end
