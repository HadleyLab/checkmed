class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :liker_id, index: true
      t.integer :likable_id, index: true

      t.timestamps
    end
    add_index :likes, [:liker_id, :likable_id], unique: true
  end
end
