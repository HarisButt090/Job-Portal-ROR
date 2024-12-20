class CreateEducations < ActiveRecord::Migration[7.2]
  def change
    create_table :educations do |t|
      t.string :institute_name
      t.string :degree
      t.date :start_date
      t.date :end_date
      t.timestamps
      t.references :job_seeker, null: false, foreign_key: true
    end
  end
end
