ActiveAdmin.register User do
  permit_params :email, :name, :company, :position,
                :avatar, :avatar_cache, :remove_avatar

  ### Setting up the menu element of this page
  menu priority: 1

## INDEX

  ### Index page Configuration
  config.batch_actions = false
  config.sort_order = 'name_asc'

  ### Index page filters
  filter :name
  filter :email
  filter :company
  filter :position
  filter :created_at

  ### Index as table
  index download_links: false do
    column :name
    column :email
    column :company
    column :position
    column :created_at
    actions
  end

## SHOW

  show do
    attributes_table do
      row :email
      row :name
      row :company
      row :position
      row :avatar do
        image_tag(user.avatar.thumb.url) unless user.avatar.blank?
      end
      row :created_at
      row :updated_at
      row 'Profile link' do
        link_to account_path(user), account_path(user), target: '_blank'
      end
    end

    panel "Tracking" do
      attributes_table_for user do
        row :sign_in_count
        row :current_sign_in_at
        row :last_sign_in_at
        row :current_sign_in_ip
        row :last_sign_in_ip
      end
    end

    panel "Checklists" do
      table_for user.checklists.ordered do
        column :name
        column :executor_role
        column :treat_stage
        column :hided
      end
    end
  end

## FORM

  form html: { multipart: true } do |f|
    f.inputs '' do
      f.input :email
      f.input :name
      f.input :company
      f.input :position
      f.input :avatar, hint: (f.object.avatar? ?
                                image_tag(f.object.avatar.thumb.url) :
                                'have no avatar')
      f.input :avatar_cache, as: :hidden
      f.input :remove_avatar, as: :boolean if f.object.avatar?
    end

    f.actions
  end

end
