class AddAwardsIndexOnJobId < ActiveRecord::Migration
  def change
  	add_index :awards, :job_id
  end
end
