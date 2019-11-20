Rails.application.routes.draw do

#get :authorize, to: "sessions#authorize"  
resources :admin

resources :sessions do
  get :authorize
end
resources :roles
resources :privileges
end
