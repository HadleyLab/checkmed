class AddLikesCountToChecklists < ActiveRecord::Migration
  def change
    add_column :checklists, :likes_count, :integer, default: 0
  end
end
