Rails.application.routes.draw do
  resources :users do
    collection do 
      get 'admin_panel' 
      post 'toggle_admin' 
    end
  end
  
  resources :art_pieces
  resources :profiles
  resources :blogs

  resources :badges

  root :to => redirect('/login')
  get '/art_pieces/:id', to: 'art_pieces#show', as: 'show_art_piece'
  get '/users/:id', to: 'users#show', as: 'show_user'
  get '/stamps/:id', to: 'users#stamps', as: 'stamps'
  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'
  get '/logout', to: 'sessions#destroy'
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  post 'logout', to: 'sessions#destroy'
  get  'logout', to: 'sessions#destroy'

  get '/clear_stamps', to: 'users#clear_stamps', as: 'clear_stamps'
  get '/clear_badges', to: 'users#clear_badges', as: 'clear_badges'


  get "password/reset", to: "password_resets#new"
  post 'password/reset', to: 'password_resets#forgot'
  get 'password/reset/edit', to: 'password_resets#edit', as: 'password_reset_edit'
  patch 'password/reset/edit', to: 'password_resets#reset'

  get 'map', to: 'map#show'

  post '/map/updateloc', to: 'map#updateloc', as: 'updateloc'
  
  get '/art_pieces/checkin/:id', to: 'art_pieces#checkin', as: 'checkin'
  get '/dummyloc', to: 'art_pieces#dummyloc', as: 'dummyloc'

end
