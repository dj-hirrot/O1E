Rails.application.routes.draw do
  namespace :admin do
    get 'home/index'
  end
  ###
  ### ADMIN
  ###
  namespace :admin do
    ###
    ### Roles
    ###
    resources :roles, only: [:index]
    ###
    ### Root
    ###
    root to: 'home#index'
  end

  ###
  ### Sessions
  ###
  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create', as: 'logins'
  delete '/logout', to: 'sessions#destroy', as: 'logout'

  ###
  ### Users
  ###
  resources :users, only: [:show, :new, :create, :edit, :update], param: :name, as: :user
  get '/join', to: 'users#new', as: 'join'
  post '/join', to: 'users#create', as: 'joins'

  ###
  ### AccountActivations, PasswordResets
  ###
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]

  ###
  ### Root
  ###
  root to: 'home#index'

  ###
  ### LetterOpener
  ###
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
