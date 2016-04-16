Rails.application.routes.draw do

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')

  resources :messages
  resources :sessions, only: [:create] 
  get '/my_profile' => 'users#my_profile'

  delete 'logout' => 'sessions#destroy'
  get '/conversations/:id', to: 'conversations#show'
  resources :messages

  resources :results
  resources :songs
  root 'results#index'

end