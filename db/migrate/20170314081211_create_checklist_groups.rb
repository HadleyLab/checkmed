class CreateChecklistGroups < ActiveRecord::Migration
  def change
    create_table :checklist_groups do |t|
      t.references :checklist, index: true, foreign_key: true, null: false
      t.string     :name,                                      null: false
      t.integer    :prior,                  default: 0,        null: false

      t.timestamps null: false
    end

    add_index :checklist_groups, :prior
  end
end
