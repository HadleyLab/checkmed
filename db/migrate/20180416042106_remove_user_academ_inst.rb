class RemoveUserAcademInst < ActiveRecord::Migration
  def change
    remove_column :users, :academ_inst
  end
end
