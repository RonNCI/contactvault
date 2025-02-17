Rails.application.routes.draw do
  # Root routes
  root "sessions#new"

  # Authentication routes
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  # Registration routes with named paths
  get "/register", to: "registrations#new", as: "new_vault_user"
  post "/register", to: "registrations#create"

  # Dashboard route
  get "/dashboard", to: "dashboard#index"

  # contacts resource for managing user contacts
  resources :contacts

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
