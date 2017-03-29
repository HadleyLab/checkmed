class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string  :ident,                  null: false
      t.integer :vtype
      t.text    :val
      t.boolean :often

      t.timestamps null: false
    end
    add_index :settings, :ident
    add_index :settings, :often
  end
end
