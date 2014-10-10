class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :group_name
      t.integer :teacher_id

      t.timestamps
    end
  end
end
