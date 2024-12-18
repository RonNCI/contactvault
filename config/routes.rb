Rails.application.routes.draw do
  # check if user is logged in for root path
  constraints lambda { |req| req.session[:user_id].present? } do
    root "dashboard#index", as: :authenticated_root
  end

  # default root path for non-authenticated users
  root "sessions#new"

  # authentication routes
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  # registration routes
  get "/register", to: "registrations#new", as: "new_vault_user"
  post "/register", to: "registrations#create", as: "vault_users"

  # dashboard route
  get "/dashboard", to: "dashboard#index"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
