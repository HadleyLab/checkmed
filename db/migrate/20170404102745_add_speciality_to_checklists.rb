class AddSpecialityToChecklists < ActiveRecord::Migration
  def change
    add_reference :checklists, :speciality, index: true, foreign_key: true
  end
end
