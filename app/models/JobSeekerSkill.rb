class JobSeekerSkill < ApplicationRecord
  # associations
  belongs_to :job_seeker
  belongs_to :skill
end
