Rails.application.routes.draw do

  root to: 'toppages#index'

  get 'signup', to: 'users#new'
  resources :users, only: [:show, :create, :edit, :update, :destroy]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  post 'characters/random', to: 'characters#random'
  get 'characters/:id/score', to: 'characters#score_edit'
  post 'characters/:id/score', to: 'characters#score_update'
  resources :characters, only: [:index, :show]

  resources :stages, only: [:index, :show]

end
