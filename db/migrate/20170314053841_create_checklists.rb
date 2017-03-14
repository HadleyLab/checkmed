class CreateChecklists < ActiveRecord::Migration
  def change
    create_table :checklists do |t|
      t.references :user,          index: true, foreign_key: true, null: false
      t.string     :name,                                          null: false
      t.references :executor_role, index: true,                    null: false
      t.integer    :treat_stage
      t.text       :descr
      t.integer    :prior,                      default: 0,        null: false
      t.boolean    :hided,                      default: false,    null: false

      t.timestamps null: false
    end

    add_index :checklists, :treat_stage
    add_index :checklists, :prior
    add_index :checklists, :hided
  end
end
