class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.boolean :fixed

      t.timestamps
    end
  end
end
