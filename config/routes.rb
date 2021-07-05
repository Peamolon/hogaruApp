Rails.application.routes.draw do
  devise_for :users
  get '/list', to: 'posts#list_by_seen'
  resources :posts
  root 'posts#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
