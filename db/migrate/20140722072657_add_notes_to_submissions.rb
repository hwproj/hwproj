class AddNotesToSubmissions < ActiveRecord::Migration
  def change
  	add_column :notes, :submission_id, :integer
  end
end
