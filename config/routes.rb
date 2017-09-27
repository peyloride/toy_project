Rails.application.routes.draw do
  root to: 'visitors#index'

  devise_for :users
  resources :toys do
    post '/lend', to: 'toys#lend'
  end
  get '/my_toys', to: 'toys#my_toys', as: 'my_toys'
end
