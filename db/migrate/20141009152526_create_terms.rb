class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.integer :course_id
      t.integer :number

      t.timestamps
    end
  end
end
