class AddNullTrueToChecklistGroupName < ActiveRecord::Migration
  def change
    change_column :checklist_groups, :name, :string, null: true
  end
end
