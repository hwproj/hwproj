class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.integer :user_id
      t.integer :term_id
      t.boolean :approved

      t.timestamps
    end
  end
end
