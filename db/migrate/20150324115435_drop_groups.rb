class DropGroups < ActiveRecord::Migration
  def up
    drop_table :groups
  end
end
