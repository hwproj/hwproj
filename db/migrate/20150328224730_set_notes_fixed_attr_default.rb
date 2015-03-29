class SetNotesFixedAttrDefault < ActiveRecord::Migration
  def change
  	change_column :notes, :fixed, :boolean, default: false
  end
end
