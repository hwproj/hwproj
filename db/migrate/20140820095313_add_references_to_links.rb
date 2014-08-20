class AddReferencesToLinks < ActiveRecord::Migration
  def change
  	add_reference :links, :parent, polymorphic: true, index: true
  end
end
