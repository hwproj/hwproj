class ChangeInvitationActive < ActiveRecord::Migration
  def change
    change_column_null(:invitations, :email,     true)
    change_column_null(:invitations, :digest,    true)
    change_column_null(:invitations, :activated, true)

    rename_column :invitations, :activated, :active
    change_column :invitations, :active, :boolean, default: true
  end
end
