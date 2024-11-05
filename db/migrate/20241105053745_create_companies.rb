class CreateCompanies < ActiveRecord::Migration[7.2]
  def change
    create_table :companies do |t|
      t.string :company_name
      t.string :industry
      t.string :address
      t.integer :employee_size

      t.timestamps
    end
  end
end
