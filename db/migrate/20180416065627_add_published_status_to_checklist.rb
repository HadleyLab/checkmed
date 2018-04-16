class AddPublishedStatusToChecklist < ActiveRecord::Migration
  def change
    add_column :checklists, :published, :boolean, default: false
  end
end
