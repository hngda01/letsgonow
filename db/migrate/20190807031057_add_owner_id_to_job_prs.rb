class AddOwnerIdToJobPrs < ActiveRecord::Migration[5.1]
  def change
    add_column :job_prs, :owner_id, :integer
  end
end
