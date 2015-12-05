class AddUserToFacts < ActiveRecord::Migration
  def change
    add_reference :facts, :user, index: true, foreign_key: true
  end
end
