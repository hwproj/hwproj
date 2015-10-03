class AddActiveToCourses < ActiveRecord::Migration
  def change
  	add_column :courses, :active, :boolean, default: true
  end
end
