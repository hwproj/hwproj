class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer :number
      t.integer :year

      t.timestamps
    end
  end
end
