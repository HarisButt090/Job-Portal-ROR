class CreateJobSeekerSkills < ActiveRecord::Migration[7.2]
  def change
    create_table :job_seeker_skills do |t|
      t.timestamps
      t.references :job_seeker, null: false, foreign_key: true
      t.references :skill, null: false, foreign_key: true
    end
  end
end
