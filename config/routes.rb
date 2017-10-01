Rails.application.routes.draw do
  root to: 'visitors#index'

  devise_for :users
  resources :toys do
    post '/request_lend', to: 'lends#lend_request'
    post '/accept_lend', to: 'lends#accept'
    post '/refuse_lend', to: 'lends#refuse'
  end
  get '/my_lends', to: 'lends#my_lends'
  get '/my_toys', to: 'toys#my_toys', as: 'my_toys'
end
