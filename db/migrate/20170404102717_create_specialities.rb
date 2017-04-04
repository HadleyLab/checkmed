class CreateSpecialities < ActiveRecord::Migration
  def change
    create_table :specialities do |t|
      t.string  :name,              null: false
      t.integer :prior, default: 9, null: false

      t.timestamps null: false
    end

    add_index :specialities, :prior
  end
end
