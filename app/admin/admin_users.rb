ActiveAdmin.register AdminUser do
  permit_params :email, :name, :password, :password_confirmation

  menu parent: 'Service'

  index do
    selectable_column
    column :name do |admin_user|
      link_to admin_user.name, admin_admin_user_path(admin_user)
    end
    column :email
    # column :current_sign_in_at
    # column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :name
  # filter :current_sign_in_at
  # filter :sign_in_count
  filter :created_at

  show do
    attributes_table do
      row :name
      row :email
      row :created_at
      row :updated_at
      row 'Remebered at', :remember_created_at
    end
  end

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :name
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
