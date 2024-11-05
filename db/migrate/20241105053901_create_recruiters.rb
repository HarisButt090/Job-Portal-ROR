class CreateRecruiters < ActiveRecord::Migration[7.2]
  def change
    create_table :recruiters do |t|
      t.references :user, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.string :department
      t.date :joined_date

      t.timestamps
    end
  end
end
