Rails.application.routes.draw do

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  post 'pingsong_conversation' => 'songs#pingsong_conversation'
  post 'pingsong' => 'songs#pingsong'
  post 'searchsong' => 'results#searhsong'
  post 'exitconversation' => 'songs#exit'
  resources :users
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