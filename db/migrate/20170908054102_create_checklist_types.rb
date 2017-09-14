class CreateChecklistTypes < ActiveRecord::Migration
  def change
    create_table :checklist_types do |t|
      t.string  :name
      t.integer :prior, default: 9, null: false
    end

    add_index :checklist_types, :prior
  end
end
