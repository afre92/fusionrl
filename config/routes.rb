Rails.application.routes.draw do
  get 'sign_up', to: 'users#new'
  # post 'users', to: 'users'
  resources :users
  get 'users/create'
  get 'dashboard/index'
  get 'sessions/create'
  get 'sessions/new'
  get 'sessions/destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
