class AddRememberMeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :remember_me_digest, :string
  end
end
