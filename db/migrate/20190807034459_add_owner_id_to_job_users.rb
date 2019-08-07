class AddOwnerIdToJobUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :job_users, :owner_id, :integer
  end
end
