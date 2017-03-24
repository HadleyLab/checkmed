class CreateChecklistItems < ActiveRecord::Migration
  def change
    create_table :checklist_items do |t|
      # t.references :checklist, index: true, foreign_key: true, null: false
      t.references :group,     index: true,                    null: false
      t.string     :title,                                     null: false
      t.text       :descr
      t.integer    :prior,                  default: 0,        null: false

      t.timestamps null: false
    end

    add_index :checklist_items, :prior
  end
end
