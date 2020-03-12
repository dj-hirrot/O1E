Rails.application.routes.draw do
  ###
  ### Session
  ###
  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create', as: 'logins'
  delete '/logout', to: 'sessions#destroy', as: 'logout'

  ###
  ### User
  ###
  resources :users, only: [:show, :new, :create, :edit, :update], param: :name, as: :user
  get '/join', to: 'users#new', as: 'join'
  post '/join', to: 'users#create', as: 'joins'

  ###
  ### AccountActivation
  ###
  resources :account_activations, only: [:edit]

  ###
  ### Root
  ###
  root to: 'home#index'
end
