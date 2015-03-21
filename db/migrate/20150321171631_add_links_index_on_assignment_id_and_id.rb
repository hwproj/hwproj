class AddLinksIndexOnAssignmentIdAndId < ActiveRecord::Migration
  def change
  	add_index :links, [ :parent_id, :id ]
  end
end
