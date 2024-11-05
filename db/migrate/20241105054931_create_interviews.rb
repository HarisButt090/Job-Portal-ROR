class CreateInterviews < ActiveRecord::Migration[7.2]
  def change
    create_table :interviews do |t|
      t.integer :status
      t.datetime :scheduled_at
      t.references :job_application, null: false, foreign_key: true

      t.timestamps
    end
  end
end
