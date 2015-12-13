class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :fact_id, index: true
      t.integer :category_id, index: true

      t.timestamps null: false
    end
    add_index :relationships, [:fact_id, :category_id], unique: true
  end
end
