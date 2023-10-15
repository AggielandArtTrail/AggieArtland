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


  get "password/reset", to: "password_resets#new"
  post 'password/reset', to: 'password_resets#forgot'
  get 'password/reset/edit', to: 'password_resets#edit', as: 'password_reset_edit'
  patch 'password/reset/edit', to: 'password_resets#reset'

  get 'map', to: 'map#show'
  post '/art_pieces/upload_icon/:id', to: 'art_pieces#upload_icon', as: 'upload_art_icon'
end
