class AddTermIdToHomeworks < ActiveRecord::Migration
  def change
    add_column :homeworks, :term_id, :integer
  end
end
