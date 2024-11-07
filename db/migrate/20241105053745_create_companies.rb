class CreateCompanies < ActiveRecord::Migration[7.2]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :industry
      t.string :address
      t.integer :employee_size
      t.timestamps
      t.references :user, null: false, foreign_key: true
    end
  end
end
