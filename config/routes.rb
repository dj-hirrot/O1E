Rails.application.routes.draw do
  get 'users/:name', to: 'users#show', as: 'user'
  get 'users/:name/edit', to: 'users#edit', as: 'edit_user'
  patch 'users/:name', to: 'users#update', as: 'users'
  get '/join', to: 'users#new', as: 'join'
  post '/join', to: 'users#create', as: 'joins'
  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create', as: 'logins'
  delete '/logout', to: 'sessions#destroy', as: 'logout'

  root to: 'home#index'
end
