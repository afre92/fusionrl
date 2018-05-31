Rails.application.routes.draw do
  get 'sign_up', to: 'users#new'
  get 'log_in', to: 'sessions#new', as: 'login'
  # post 'users', to: 'users'
  resources :users
  resources :sessions
  get 'users/create'
  get 'dashboard/index'
  root to: 'dashboard#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
