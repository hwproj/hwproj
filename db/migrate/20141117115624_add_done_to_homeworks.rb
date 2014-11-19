class AddDoneToHomeworks < ActiveRecord::Migration
  def change
    add_column :homeworks, :done, :boolean, default: false
  end
end
