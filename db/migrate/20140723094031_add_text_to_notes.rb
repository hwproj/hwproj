class AddTextToNotes < ActiveRecord::Migration
  def change
  	add_column :notes, :text, :string
  end
end
