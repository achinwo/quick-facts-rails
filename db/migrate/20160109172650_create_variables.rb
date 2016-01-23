class CreateVariables < ActiveRecord::Migration
  def change
    create_table :variables do |t|
      t.integer :user
      t.string :name
      t.text :value
      t.boolean :deleted

      t.timestamps null: false
    end
  end
end
