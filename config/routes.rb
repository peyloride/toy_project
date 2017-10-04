Rails.application.routes.draw do
  root to: 'visitors#index'

  devise_for :users

  resources :toys do
    resources :comments do
      post '/like', to: 'comments#like'
    end
    post '/request_lend', to: 'lends#lend_request'
    post '/accept_lend', to: 'lends#accept'
    post '/refuse_lend', to: 'lends#refuse'
    post '/like', to: 'toys#like'
  end

  get '/my_lends', to: 'lends#my_lends'
  get '/my_toys', to: 'toys#my_toys', as: 'my_toys'
end
