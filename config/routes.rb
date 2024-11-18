Rails.application.routes.draw do
  root "pages#landing"

  devise_for :users, controllers: { registrations: "registrations", sessions: "devise/sessions" }

  devise_scope :user do
    post "users/update_role", to: "registrations#update_role", as: :update_role
    get "verify_email", to: "registrations#verify_email", as: "verify_email"
  end

  namespace :company do
    get "dashboard", to: "dashboard#index", as: "dashboard"
  end

  get "up", to: "rails/health#show", as: :rails_health_check

  get "service-worker", to: "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest", to: "rails/pwa#manifest", as: :pwa_manifest

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
