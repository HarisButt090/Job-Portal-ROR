class CreateJobSeekers < ActiveRecord::Migration[7.2]
  def change
    create_table :job_seekers do |t|
      t.references :user, null: false, foreign_key: true
      t.string :linkedin_profile_url
      t.string :github_portfolio_url
      t.integer :preferred_job_type, default: 0
      t.string :city
      t.string :address

      t.timestamps
    end
  end
end
