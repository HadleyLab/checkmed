ActiveAdmin.register ExecutorRole do
  permit_params :name, :prior

  config.sort_order = 'prior_asc'
end
