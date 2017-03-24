ActiveAdmin.register Checklist do
  permit_params :name

  actions :all, except: [:create, :edit, :update, :destroy]

  menu priority: 2

## INDEX

  ### Index page Configuration
  config.batch_actions = false

  ### Index page scopes
  scope :all, default: true
  scope :visibles

  ### Index page filters
  filter :user_id, label: "User id"
  filter :executor_role
  filter :name
  filter :descr
  filter :treat_stage
  filter :hided

  ### Index as table
  index download_links: false

## SHOW

  show do
    attributes_table do
      row :user
      row :name
      row :descr
      row :executor_role
      row :treat_stage
    end

    panel "Questions" do
      checklist.groups.ordered.each do |group|
        para group.name, style: "font-weight:bold"
        if group.items.any?
          table_for group.items.ordered do
            column :title
            column :descr
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

## SIDEBARS

  sidebar 'Additional data', only: :show do
    attributes_table_for checklist do
      # row(:hided) { checklist.hided? ? t('yep') : t('nope') }
      row :hided
      row :created_at
      row :updated_at
    end
  end

end
