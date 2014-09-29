class CreateAwards < ActiveRecord::Migration
  def change
    create_table :awards do |t|
      t.integer :job_id
      t.integer :rank

      t.timestamps
    end
  end
end
