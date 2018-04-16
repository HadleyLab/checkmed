ActiveAdmin.register User do
  permit_params :email, :name, :company, :academ_inst, :position,
                :avatar, :avatar_cache, :remove_avatar,
                :password, :password_confirmation, :banned,
                :make_user_confirmed

  ### Setting up the menu element of this page
  menu priority: 1

  ### Custom Controller Actions
  member_action :ban_this_user, method: [:get, :post] do
    if resource.banned?
      ntcmsg = "Already banned."
    else
      resource.update banned: true
      ntcmsg = "#{resource.name} banned!"
    end
    redirect_to resource_path, notice: ntcmsg
  end
  member_action :unban_this_user, method: [:get, :post] do
    if resource.banned?
      resource.update banned: false
      ntcmsg = "#{resource.name} unbanned!"
    else
      ntcmsg = "Already have no ban."
    end
    redirect_to resource_path, notice: ntcmsg
  end

## INDEX

  ### Index page Configuration
  config.batch_actions = false
  config.sort_order = 'name_asc'

  ### Index page filters
  filter :name
  filter :email
  filter :company
  filter :academ_inst
  filter :position
  filter :created_at
  filter :banned

  ### Index as table
  index download_links: false do
    column :name
    column :email
    column :company
    column :academ_inst
    column :position
    column :banned
    column 'Checklists' do |user|
      user.checklists.size
    end
    column :created_at
    actions do |user|
      if user.banned?
        link_to "Unban", unban_this_user_admin_user_path(user)
      else
        link_to "Ban", ban_this_user_admin_user_path(user)
      end
    end
  end

## SHOW

  show do
    attributes_table do
      row :email
      row :name
      row :company
      row :academ_inst
      row :position
      row :avatar do
        image_tag(user.avatar.thumb.url) unless user.avatar.blank?
      end
      row :banned
      row :created_at
      row :updated_at
      row 'Profile link' do
        link_to account_path(user), account_path(user), target: '_blank'
      end
    end

    panel "Tracking" do
      attributes_table_for user do
        row 'Other users checklists visited' do
          user.checklists_visits.group(:checklist_id).count.length
        end
        row :sign_in_count
        row :current_sign_in_at
        row :last_sign_in_at
        row :current_sign_in_ip
        row :last_sign_in_ip
        row :confirmation_sent_at
        row :unconfirmed_email
        row :confirmed_at
      end
    end

    panel "Checklists" do
      table_for user.checklists.ordered do
        column :name
        column :executor_role
        column :speciality
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
      f.input :academ_inst
      f.input :position
      f.input :avatar, hint: (f.object.avatar? ?
                                image_tag(f.object.avatar.thumb.url) :
                                'have no avatar')
      f.input :avatar_cache, as: :hidden
      f.input :remove_avatar, as: :boolean if f.object.avatar?
      if f.object.new_record?
        f.input :password
        f.input :password_confirmation
      end
      f.input :banned
      unless f.object.confirmed?
        f.input :make_user_confirmed, label: 'Confirm user', as: :boolean
      end
    end

    f.actions
  end

end
