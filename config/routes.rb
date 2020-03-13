Rails.application.routes.draw do
  ###
  ### ADMIN
  ###
  namespace :admin do
    resources :categories, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :users, only: [:index]

    root to: 'home#index'
  end

  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create', as: 'logins'
  delete '/logout', to: 'sessions#destroy', as: 'logout'

  resources :users, only: [:show, :new, :create, :edit, :update], param: :name, as: :user
  get '/join', to: 'users#new', as: 'join'
  post '/join', to: 'users#create', as: 'joins'

  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]

  root to: 'home#index'

  ###
  ### LetterOpener
  ###
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  get '*path', controller: 'errors', action: 'render_404'
end
