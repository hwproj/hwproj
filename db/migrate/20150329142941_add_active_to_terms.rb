class AddActiveToTerms < ActiveRecord::Migration
  def change
  	add_column :terms, :active, :boolean, default: true
  end
end
