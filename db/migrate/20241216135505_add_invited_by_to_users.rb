class AddInvitedByToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :invited_by_id, :integer
  end
end
