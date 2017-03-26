class CreateUsersChecklistsVisits < ActiveRecord::Migration
  def change
    create_table :users_checklists_visits do |t|
      t.references :user,      index: true, foreign_key: true, null: false
      t.references :checklist, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
