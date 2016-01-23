class AddDeleted < ActiveRecord::Migration
  def change
    add_column :users, :deleted, :boolean, default: false
    add_column :facts, :deleted, :boolean, default: false
  end
end
