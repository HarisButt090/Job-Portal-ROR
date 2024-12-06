class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :role, default: 0
      t.string :contact_no
      t.integer :status, default: 0

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
