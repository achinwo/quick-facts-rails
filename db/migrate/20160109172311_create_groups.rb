class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.integer :user_id, index: true
      t.boolean :deleted, default: false

      t.timestamps null: false
    end
  end
end
