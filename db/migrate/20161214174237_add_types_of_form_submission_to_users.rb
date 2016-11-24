class AddTypesOfFormSubmissionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :settings, :text, null: false, default: "{}"
  end
end
