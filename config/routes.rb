Rails.application.routes.draw do
  root "pages#landing"

  devise_for :users, controllers: { registrations: "registrations", sessions: "devise/sessions" }

  devise_scope :user do
    get "verify_email", to: "registrations#verify_email", as: "verify_email"
    get "company_details", to: "registrations#company_details", as: "company_details"
    post "save_company_details", to: "registrations#save_company_details", as: "save_company_details"
    get "job_seeker_details", to: "registrations#job_seeker_details", as: "job_seeker_details"
    post "save_job_seeker_details", to: "registrations#save_job_seeker_details", as: "save_job_seeker_details"
  end

  namespace :admin do
    get "dashboard", to: "dashboard#index", as: "dashboard"
  end

  namespace :job_seeker do
    get "dashboard", to: "dashboard#index", as: "dashboard"

    resources :jobs, only: [:show] do
      member do
        get :apply
        post :submit_application
      end
    end

    get "applications", to: "jobs#my_applications", as: "my_applications"
    get 'applications/:id', to: 'jobs#show_application', as: 'application'
  end
  
  namespace :company do
    get "dashboard", to: "dashboard#index", as: "dashboard"

    resources :jobs, only: [:new, :create, :show, :edit, :update, :destroy] do
      collection do
        get :drafts
        get :manage
        get :archived
        get :applications_overview
      end
      member do
        patch :publish
        patch :close
        patch :open
        get :show_applications
        get :view_application
        patch :accept_application
        patch :reject_application
        get :schedule_interview
        post :create_interview
        patch :update_interview_status
      end
    end

    resources :employers, only: [:new, :create]
  end

  get "up", to: "rails/health#show", as: :rails_health_check
  get "service-worker", to: "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest", to: "rails/pwa#manifest", as: :pwa_manifest

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
