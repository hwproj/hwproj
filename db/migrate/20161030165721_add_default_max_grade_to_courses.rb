class AddDefaultMaxGradeToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :default_max_grade, :integer, default: 1, null: false
  end
end
