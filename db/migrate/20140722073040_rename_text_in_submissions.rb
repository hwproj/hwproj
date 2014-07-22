class RenameTextInSubmissions < ActiveRecord::Migration
  def change
  	rename_column :submissions, :note, :text
  end
end
