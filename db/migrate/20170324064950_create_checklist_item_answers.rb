class CreateChecklistItemAnswers < ActiveRecord::Migration
  def change
    create_table :checklist_item_answers do |t|
      t.references :checklist_item, index: true, foreign_key: true, null: false
      t.string     :val,                                            null: false
      t.string     :tip
      t.boolean    :commentable
      t.integer    :prior,                       default: 0,        null: false

      t.timestamps null: false
    end

    add_index :checklist_item_answers, :prior
  end
end
