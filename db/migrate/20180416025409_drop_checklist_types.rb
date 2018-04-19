class DropChecklistTypes < ActiveRecord::Migration
  def change
    drop_table :checklist_types, force: :cascade
  end
end
