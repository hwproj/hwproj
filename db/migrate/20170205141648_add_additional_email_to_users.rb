class AddAdditionalEmailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :additional_email, :string, default: "", null: false
  end
end
