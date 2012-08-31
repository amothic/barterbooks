class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :user_id
      t.integer :book_id

      t.timestamps
    end
    
    add_index :relationships, :user_id
    add_index :relationships, :book_id
    add_index :relationships, [:user_id, :book_id], unique: true

  end
end
