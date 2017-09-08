class AddChecklistTypeToChecklists < ActiveRecord::Migration
  def change
    add_reference :checklists, :checklist_type, index: true, foreign_key: true
  end
end
