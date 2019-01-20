Rails.application.routes.draw do

  root :to => "static#calculate"
  

  resources :drivers
  resources :vehicles
  resources :routes
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
