Rails.application.routes.draw do
  resources :feeds, only: :update
  root 'feeds#index'
  post '/feeds/update'
end
