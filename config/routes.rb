Rails.application.routes.draw do
  devise_for :users
  resources :posts

  resources :users, only: [:update, :show]
  get 'owner', to: 'posts#owner'
  get 'profile', to: 'users#profile'

  resources :cities, only: [:index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
