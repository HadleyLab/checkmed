Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, path: 'profile',
                     controllers: {
                       passwords: 'users/passwords',
                       registrations: 'users/registrations',
                       confirmations: 'users/confirmations',
                       sessions: 'users/sessions' }

  scope 'profile' do
    resources :checklists, except: :index
  end
  get 'search', to: 'checklists#index', as: :search

  get 'account/:id', to: 'profiles#show', as: :account

  get 'profile',            to: 'profiles#redirect_to_show', as: :profile_root
  get 'profile/checklists', to: 'profiles#redirect_to_show', as: :profile_checklists_root

  root 'pages#home'
end
