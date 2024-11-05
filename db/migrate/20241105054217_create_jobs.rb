class CreateJobs < ActiveRecord::Migration[7.2]
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :address
      t.string :city
      t.text :job_description
      t.text :responsibilities
      t.text :requirements
      t.integer :experience
      t.integer :salary
      t.text :qualification
      t.integer :job_type
      t.integer :displayed_status
      t.integer :job_status
      t.references :employer, null: false, foreign_key: true
      t.date :job_posted_at

      t.timestamps
    end
  end
end
