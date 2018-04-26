class AddFollowersCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :followers_count, :integer, default: 0
    add_column :users, :followed_count, :integer, default: 0
  end
end
