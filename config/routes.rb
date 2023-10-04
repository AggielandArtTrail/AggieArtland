Rails.application.routes.draw do
  resources :users
  resources :art_pieces
  root :to => redirect('/login')
  get '/art_pieces/:id', to: 'art_pieces#show', as: 'show_art_piece'
  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'
  get '/logout', to: 'sessions#destroy'
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  post 'logout', to: 'sessions#destroy'
  get  'logout', to: 'sessions#destroy'

  get 'map', to: 'map#show'
end
