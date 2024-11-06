Rails.application.routes.draw do
<<<<<<< HEAD
  devise_for :users
<<<<<<< HEAD
  # Letter opener route
=======
  root "pages#landing"
  devise_for :users, controllers: { registrations: "registrations", sessions: "devise/sessions" }
  get "verification_success", to: "registrations#verification_success", as: "verification_success"
  get "dashboard", to: "dashboard#index", as: :dashboard

>>>>>>> fcd77f3 (Company Registration through devise and redirecting to dashboard)
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
=======
  resources :friends
  get "home/about"
  root "home#index"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
>>>>>>> a05a5ac (Configured devise)

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
