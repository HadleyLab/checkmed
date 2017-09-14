namespace :bootstrap do
  desc "Create initial checklist types"
  task :initial_checklist_types => :environment do
    ChecklistType.where(name: 'Checklist').first_or_create(prior: 1)
    ChecklistType.where(name: 'Protocol').first_or_create(prior: 2)
  end

  desc "Setup default checklist type for checklists"
  task :default_checklist_type_for_checklists => :environment do
    default_checklist_type = ChecklistType.find_by(name: 'Checklist')
    Checklist.where(checklist_type_id: nil).each do |checklist|
      checklist.checklist_type = default_checklist_type
      checklist.save
    end
  end

  desc "Run all bootstrapping tasks"
  task :all => [:initial_checklist_types, :default_checklist_type_for_checklists]
end