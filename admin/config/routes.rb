Rails.application.routes.draw do

#get :authorize, to: "sessions#authorize"  
resources :tenants, only: [:create, :destroy]
resources :users

resources :sessions do
  get :authorize
end
resources :roles
resources :privileges
end
