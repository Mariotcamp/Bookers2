Rails.application.routes.draw do
  devise_for :users
  root to: 'tops#index'
  get '/home/about' => 'abouts#index'
  resources :users, only: [:show,:index,:edit,:update] #なぜかusers#indexだけ作成されない→resouceになってた
  resources :books
end
