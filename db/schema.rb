# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_11_07_115452) do
  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "industry"
    t.string "address"
    t.integer "employee_size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_companies_on_user_id"
  end

  create_table "educations", force: :cascade do |t|
    t.string "institute_name"
    t.string "degree"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "job_seeker_id", null: false
    t.index ["job_seeker_id"], name: "index_educations_on_job_seeker_id"
  end

  create_table "experiences", force: :cascade do |t|
    t.string "company_name"
    t.string "position"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "job_seeker_id", null: false
    t.index ["job_seeker_id"], name: "index_experiences_on_job_seeker_id"
  end

  create_table "interviews", force: :cascade do |t|
    t.integer "status", default: 0
    t.datetime "scheduled_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "job_application_id", null: false
    t.index ["job_application_id"], name: "index_interviews_on_job_application_id"
  end

  create_table "job_applications", force: :cascade do |t|
    t.float "total_experience"
    t.string "last_organization"
    t.string "latest_degree"
    t.boolean "is_education_completed"
    t.integer "graduated_year"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "job_id", null: false
    t.integer "job_seeker_id", null: false
    t.index ["job_id"], name: "index_job_applications_on_job_id"
    t.index ["job_seeker_id"], name: "index_job_applications_on_job_seeker_id"
  end

  create_table "job_seeker_skills", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "job_seeker_id", null: false
    t.integer "skill_id", null: false
    t.index ["job_seeker_id"], name: "index_job_seeker_skills_on_job_seeker_id"
    t.index ["skill_id"], name: "index_job_seeker_skills_on_skill_id"
  end

  create_table "job_seekers", force: :cascade do |t|
    t.string "linkedin_profile_url"
    t.string "github_portfolio_url"
    t.integer "preferred_job_type", default: 0
    t.string "city"
    t.string "address"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_job_seekers_on_user_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "title"
    t.string "address"
    t.string "city"
    t.text "job_description"
    t.text "responsibilities"
    t.text "requirements"
    t.integer "experience"
    t.integer "salary"
    t.text "qualification"
    t.integer "job_type", default: 0
    t.integer "displayed_status", default: 0
    t.integer "job_status", default: 0
    t.date "job_posted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "recruiter_id"
    t.integer "company_id", null: false
    t.index ["company_id"], name: "index_jobs_on_company_id"
    t.index ["recruiter_id"], name: "index_jobs_on_recruiter_id"
  end

  create_table "recruiters", force: :cascade do |t|
    t.string "department"
    t.date "joined_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "company_id", null: false
    t.index ["company_id"], name: "index_recruiters_on_company_id"
    t.index ["user_id"], name: "index_recruiters_on_user_id"
  end

  create_table "skills", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "role", default: 0
    t.string "contact_no"
    t.integer "status", default: 0
    t.integer "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "companies", "users"
  add_foreign_key "educations", "job_seekers"
  add_foreign_key "experiences", "job_seekers"
  add_foreign_key "interviews", "job_applications"
  add_foreign_key "job_applications", "job_seekers"
  add_foreign_key "job_applications", "jobs"
  add_foreign_key "job_seeker_skills", "job_seekers"
  add_foreign_key "job_seeker_skills", "skills"
  add_foreign_key "job_seekers", "users"
  add_foreign_key "jobs", "companies"
  add_foreign_key "jobs", "recruiters"
  add_foreign_key "recruiters", "companies"
  add_foreign_key "recruiters", "users"
  add_foreign_key "users", "companies"
end
