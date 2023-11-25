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
  #resources :app_settings

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

  get '/engagement_tracking/:time/', to: 'users#engagement_tracking', as: 'engagement_tracking'

  get '/clear_stamps', to: 'users#clear_stamps', as: 'clear_stamps'
  get '/clear_badges', to: 'users#clear_badges', as: 'clear_badges'

  get '/remove_badge_icon/:id', to: 'badges#remove_custom_icon', as: 'remove_badge_icon'
  get '/remove_default_stamp_icon', to: 'app_settings#remove_default_stamp_icon', as: 'remove_default_stamp_icon'
  get '/remove_default_badge_icon', to: 'app_settings#remove_default_badge_icon', as: 'remove_default_badge_icon'

  get '/app_settings', to: 'app_settings#edit', as: 'app_setting'
  patch '/app_settings', to: 'app_settings#update'

  get "password/reset", to: "password_resets#new"
  post 'password/reset', to: 'password_resets#forgot'
  get 'password/reset/edit', to: 'password_resets#edit', as: 'password_reset_edit'
  patch 'password/reset/edit', to: 'password_resets#reset'

  get 'map', to: 'map#show'

  post '/map/updateloc', to: 'map#updateloc', as: 'updateloc'
  
  get '/art_pieces/checkin/:id', to: 'art_pieces#checkin', as: 'checkin'
  get '/dummyloc', to: 'art_pieces#dummyloc', as: 'dummyloc'

end
