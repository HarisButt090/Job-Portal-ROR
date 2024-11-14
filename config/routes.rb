Rails.application.routes.draw do
  root "pages#landing"

  devise_for :users, controllers: { registrations: "registrations", sessions: "devise/sessions" }

  devise_scope :user do
    get "register/company_admin", to: "registrations#new_company_admin", as: "new_company_admin_registration"
    post "register", to: "registrations#create", as: "create_registration"
    get "verification_success", to: "registrations#verification_success", as: "verification_success"
  end

  namespace :company do
    get "dashboard", to: "dashboard#index", as: "dashboard"
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
