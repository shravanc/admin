Rails.application.routes.draw do
  
resources :admin

resources :sessions
resources :roles
resources :privileges
end
