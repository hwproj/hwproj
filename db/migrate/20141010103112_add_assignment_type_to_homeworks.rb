class AddAssignmentTypeToHomeworks < ActiveRecord::Migration
  def change
    add_column :homeworks, :assignment_type, :integer
  end
end
