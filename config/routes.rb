Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Root path
  root "pages#home"

  # Authentication routes (Rails 8 built-in)
  resource :session, only: [:new, :create, :destroy]
  resources :passwords, param: :token, only: [:new, :create, :edit, :update]
  
  # Registration routes (custom - not included in Rails 8 auth)
  get "signup", to: "registrations#new"
  post "signup", to: "registrations#create"

  # Convenience routes
  get "login", to: "sessions#new"
  delete "logout", to: "sessions#destroy"

  # Dashboard (protected)
  get "dashboard", to: "pages#dashboard"
end
