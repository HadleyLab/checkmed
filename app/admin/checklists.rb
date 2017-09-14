ActiveAdmin.register Checklist do
  permit_params :hided

  includes :user, :executor_role, :speciality

  actions :all, except: [:new, :create, :edit, :update]

  menu priority: 2

## INDEX

  ### Index page Configuration
  config.batch_actions = true

  ### Batch actions
  batch_action :hide do |ids|
    batch_action_collection.find(ids).each do |checklist|
      checklist.hided = true
      checklist.save
    end
    redirect_to collection_path, alert: "The selected checklists became hidden"
  end

  batch_action :unhide do |ids|
    batch_action_collection.find(ids).each do |checklist|
      checklist.hided = false
      checklist.save
    end
    redirect_to collection_path, alert: "The selected checklists became visible"
  end

# ### Index page scopes
  # scope :all, default: true
  # scope :visibles

  ### Index page filters
  filter :name
  filter :descr
  filter :treat_stage
  filter :checklist_type
  filter :executor_role
  filter :speciality
  filter :user_id, label: "Author id"
  filter :hided
  filter :created_at

  ### Index as table
  index download_links: false do
    selectable_column
    id_column
    column :name
    column :treat_stage
    column :checklist_type
    column :executor_role
    column :speciality
    column :user
    column :hided
    column :created_at do |checklist|
      l checklist.created_at, format: :short
    end
    actions
  end

## SHOW

  show do
    attributes_table do
      row :name
      row :descr
      row :treat_stage
      row :checklist_type
      row :executor_role
      row :speciality
      row :user
      row :hided
      row :created_at
      row :updated_at
    end

    panel 'Tracking' do
      attributes_table_for checklist do
        row 'Visits count' do
          checklist.users_visits.count
        end
        row 'Visitors count' do
          checklist.users_visits.group(:user_id).count.length
        end
      end
    end

    panel "Questions" do
      checklist.groups.ordered.each do |group|
        h4 group.name, style: "font-weight:bold"

        if group.items.any?
          table_for group.items.ordered do
            column :comment do |question|
              if question.title.present?
                span strong question.title
                br
                span question.descr
              else
                a href: question.picture.url, target: '_blank' do
                  img src: question.picture.thumb.url
                end
              end
            end

            column :answers do |question|
              if question.answers.any?
                table_for question.answers.ordered do
                  column :val
                  column :tip
                  column :commentable
                end
              else
                'free text answer'
              end
            end
          end
        else
          para "There are no questions in this group..", style: 'font-size:10px;'
        end
      end
    end
  end

end
