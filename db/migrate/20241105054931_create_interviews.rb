class CreateInterviews < ActiveRecord::Migration[7.2]
  def change
    create_table :interviews do |t|
      t.integer :status, default: 0
      t.datetime :scheduled_at
      t.timestamps
      t.references :job_application, null: false, foreign_key: true
    end
  end
end
