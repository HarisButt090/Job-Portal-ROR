class CreateExperiences < ActiveRecord::Migration[7.2]
  def change
    create_table :experiences do |t|
      t.string :company_name
      t.string :position
      t.date :start_date
      t.date :end_date
      t.timestamps
      t.references :job_seeker, null: false, foreign_key: true
    end
  end
end
