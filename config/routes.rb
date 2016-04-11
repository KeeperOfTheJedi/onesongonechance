Rails.application.routes.draw do
  resources :results
  resources :users
  resources :songs
  resources :sessions, only: [:new, :create] 
  delete 'logout' => 'sessions#destroy'

  # root 'welcome#index'
  root 'results#index'

end
