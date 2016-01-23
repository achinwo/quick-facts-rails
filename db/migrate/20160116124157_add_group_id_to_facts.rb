class AddGroupIdToFacts < ActiveRecord::Migration
  def change
    add_column :facts, :group_id, :integer
  end
end
