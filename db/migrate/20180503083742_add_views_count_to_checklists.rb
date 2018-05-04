class AddViewsCountToChecklists < ActiveRecord::Migration
  def change
    add_column :checklists, :views_count, :integer, default: 0, null: false
  end
end
