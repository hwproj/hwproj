class AddAssignmentsIndexOnTermIdAndId < ActiveRecord::Migration
  def change
  	add_index :homeworks, [ :term_id, :id ]
  end
end
