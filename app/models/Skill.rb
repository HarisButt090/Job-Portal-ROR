class Skill < ApplicationRecord
  has_many :job_seeker_skills, dependent: :destroy
  has_many :job_seekers, through: :job_seeker_skills
end
