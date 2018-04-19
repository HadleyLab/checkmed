class RemoveTreatStageFromChecklist < ActiveRecord::Migration
  def change
    remove_column :checklists, :treat_stage
  end
end
