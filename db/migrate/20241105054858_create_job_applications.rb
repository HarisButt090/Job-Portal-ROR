class CreateJobApplications < ActiveRecord::Migration[7.2]
  def change
    create_table :job_applications do |t|
      t.float :total_experience
      t.string :last_organization
      t.string :latest_degree
      t.boolean :is_education_completed
      t.integer :graduated_year
      t.integer :status, default: 0
      t.timestamps
      t.references :job, null: false, foreign_key: true
      t.references :job_seeker, null: false, foreign_key: true
    end
  end
end
