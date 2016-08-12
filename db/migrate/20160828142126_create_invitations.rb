class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string  :email,     null: false
      t.string  :digest,    null: false
      t.boolean :activated, null: false, default: false

      t.timestamps
    end
    add_index :invitations, :email
  end
end
