Rails.application.routes.draw do
  root to: 'visitors#index'

  devise_for :users
  resources :toys
  get '/my_toys', to: 'toys#my_toys', as: 'my_toys'
end
