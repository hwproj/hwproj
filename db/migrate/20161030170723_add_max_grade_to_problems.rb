class AddMaxGradeToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :max_grade, :integer, default: 1, null: false
  end
end
