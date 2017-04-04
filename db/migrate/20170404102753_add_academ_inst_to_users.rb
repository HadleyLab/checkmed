class AddAcademInstToUsers < ActiveRecord::Migration
  def change
    add_column :users, :academ_inst, :string
  end
end
