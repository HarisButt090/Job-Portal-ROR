Rails.application.routes.draw do
  root "pages#landing"

  devise_for :users, controllers: { registrations: "registrations", sessions: "devise/sessions" }

  devise_scope :user do
<<<<<<< HEAD
    get "verify_email", to: "registrations#verify_email", as: "verify_email"
    get "company_details", to: "registrations#company_details", as: "company_details"
    post "save_company_details", to: "registrations#save_company_details", as: "save_company_details"
    get "job_seeker_details", to: "registrations#job_seeker_details", as: "job_seeker_details"
    post "save_job_seeker_details", to: "registrations#save_job_seeker_details", as: "save_job_seeker_details"

  namespace :job_seeker do
    get "dashboard", to: "dashboard#index", as: "dashboard"
=======
    get "register/company_admin", to: "registrations#new_company_admin", as: "new_company_admin_registration"
    get "register/job_seeker", to: "registrations#new_job_seeker", as: "new_job_seeker_registration"
    post "register", to: "registrations#create", as: "create_registration"
    get "verification_success", to: "registrations#verification_success", as: "verification_success"
>>>>>>> ea09662 (Registered job seeker and redirected to dashboard)
  end

  namespace :job_seeker do
    get "dashboard", to: "dashboard#index", as: "dashboard"
  end

  namespace :company do
    get "dashboard", to: "dashboard#index", as: "dashboard"
  end

  get "up", to: "rails/health#show", as: :rails_health_check

  get "service-worker", to: "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest", to: "rails/pwa#manifest", as: :pwa_manifest

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
