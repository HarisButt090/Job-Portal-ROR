class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :role
      t.string :contact_no
      t.integer :status
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
