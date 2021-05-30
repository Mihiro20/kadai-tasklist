Rails.application.routes.draw do
  get 'users/new'
  get 'users/create'
  get 'users/create'
  get 'users/new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'tasks#index'
  
  get 'signup', to: 'users#new'
  resources :tasks
end