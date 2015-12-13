class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :extension
      t.integer :fact_id

      t.timestamps null: false
    end
  end
end
