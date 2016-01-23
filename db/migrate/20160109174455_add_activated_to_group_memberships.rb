class AddActivatedToGroupMemberships < ActiveRecord::Migration
  def change
    add_column :group_memberships, :activated, :boolean, default: false
    add_column :group_memberships, :activtation_digest, :string
  end
end
