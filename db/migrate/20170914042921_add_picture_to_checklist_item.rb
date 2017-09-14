class AddPictureToChecklistItem < ActiveRecord::Migration
  def change
    add_column :checklist_items, :picture, :string
  end
end
