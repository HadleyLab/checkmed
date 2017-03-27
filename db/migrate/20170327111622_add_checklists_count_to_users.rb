class AddChecklistsCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :checklists_count, :integer
  end
end
