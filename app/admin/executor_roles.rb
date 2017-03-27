ActiveAdmin.register ExecutorRole do
  permit_params :name, :prior

  actions :all, except: [:show]

  config.sort_order = 'prior_asc'

  filter :name
  filter :prior

  index download_links: false do
    selectable_column
    column :name
    column :prior
    actions
  end
end
