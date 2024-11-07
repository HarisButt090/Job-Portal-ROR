class RemoveCompanyFromUsers < ActiveRecord::Migration[7.2]
  def change
    remove_reference :users, :company, foreign_key: true
  end
end
