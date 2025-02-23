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
    post 'profile/checklists/:id/publish', to: 'checklists#publish', as: :checklist_publish
  end

  post '/account/:id/follow', to: 'relationships#create', as: :follow
  post '/accounts/:id/unfollow', to: 'relationships#destroy', as: :unfollow

  post '/profile/checklists/like', to: 'likes#create', as: :like
  post '/profile/checklists/dislike', to: 'likes#destroy', as: :dislike
  get 'top', to: 'pages#top', as: :checklist_top

  get 'search', to: 'checklists#index', as: :search

  get 'account/:id', to: 'profiles#show', as: :account

  get 'profile',            to: 'profiles#redirect_to_show', as: :profile_root
  get 'profile/checklists', to: 'profiles#redirect_to_show', as: :profile_checklists_root

  get '*page_path' => 'pages#show', as: :page

  root 'pages#home'
end
