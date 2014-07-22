class AddVersionToSubmissions < ActiveRecord::Migration
  def change
  	add_column :submissions, :version, :integer
  end
end
