Rails.application.routes.draw do
  devise_for :users
  get '/list', to: 'posts#list_by_seen'
  get '/list_my_post', to: 'posts#list_my_post'
  get '/list_by_id/id', to: 'visits#list_by_id'
  resources :posts
  root 'posts#index'
  #root 'visits#list_by_id'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
