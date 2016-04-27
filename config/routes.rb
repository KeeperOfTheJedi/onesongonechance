Rails.application.routes.draw do

  devise_for :users
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  post 'pingsong_conversation' => 'songs#pingsong_conversation'
  post 'get_new_song' => 'songs#getnewsong'
  post 'add_song_in_conversation' => 'songs#addsong'
  post 'pingsong' => 'songs#pingsong'
  post 'searchsong' => 'results#searhsong'
  post 'exitconversation' => 'songs#exit'
  resources :users
  resources :messages
  resources :sessions, only: [:create] 
  get '/my_profile' => 'users#my_profile'
  resources :user_pictures
  get '/user_pictures_choosing/:id/:album_id' => 'user_pictures#choosing', as: 'user_pictures_choosing'
  get '/user_pictures_pick/:id/:photo_id' => 'user_pictures#pick', as: 'user_pictures_pick'

  delete 'logout' => 'sessions#destroy'
  get '/conversations/:id', to: 'conversations#show'
  resources :messages

  resources :results
  resources :songs
  root 'results#index'

end