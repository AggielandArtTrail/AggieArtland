Rails.application.routes.draw do
  resources :users

  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'
  get '/logout', to: 'sessions#destroy'
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  post 'logout', to: 'sessions#destroy'
  get  'logout', to: 'sessions#destroy'
end
