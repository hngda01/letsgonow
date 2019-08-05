class CreateJobUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :job_users do |t|
      t.integer :micropost_id
      t.integer :user_id
    end
  end
end
