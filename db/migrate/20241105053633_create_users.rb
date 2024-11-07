class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :role, default: 0
      t.string :contact_no
      t.integer :status, default: 0
<<<<<<< HEAD:db/migrate/20241105053633_create_users.rb
      t.references :company, null: false, foreign_key: true

=======
      t.references :company, null: true, foreign_key: true
>>>>>>> 04357b1 (Resolved conflicts and added to git ignore):db/migrate/20241105083850_create_users.rb
      t.timestamps
    end
  end
end
