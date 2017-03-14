Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  devise_for :users, path: 'profile',
                     controllers: {
                       passwords: 'users/passwords',
                       registrations: 'users/registrations',
                       sessions: 'users/sessions' }

  get 'account/:id', to: 'profiles#show', as: :account

  get 'search', to: 'pages#search', as: :search

  root 'pages#home'
end
