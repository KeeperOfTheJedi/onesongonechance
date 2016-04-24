Rails.application.routes.draw do

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  post 'pingsong' => 'songs#pingsong'
  resources :users
  resources :messages
  resources :sessions, only: [:create] 
  get '/my_profile' => 'users#my_profile'
  resources :user_pictures
  get '/user_pictures_choose/:id/:album_id' => 'user_pictures#choose', as: 'user_pictures_choose'

  delete 'logout' => 'sessions#destroy'
  get '/conversations/:id', to: 'conversations#show'
  resources :messages

  resources :results
  resources :songs
  root 'results#index'

end