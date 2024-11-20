Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"

  root "pages#landing"

  devise_for :users, controllers: { registrations: "registrations", sessions: "devise/sessions" }

  devise_scope :user do
    get "verify_email", to: "registrations#verify_email", as: "verify_email"
    get "company_details", to: "registrations#company_details", as: "company_details"
    post "save_company_details", to: "registrations#save_company_details", as: "save_company_details"
  end

  namespace :company do
    get "dashboard", to: "dashboard#index", as: "dashboard"
  end

  get "up", to: "rails/health#show", as: :rails_health_check

  get "service-worker", to: "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest", to: "rails/pwa#manifest", as: :pwa_manifest

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
