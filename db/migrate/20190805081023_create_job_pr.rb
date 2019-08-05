class CreateJobPr < ActiveRecord::Migration[5.1]
  def change
    create_table :job_prs do |t|
      t.integer :micropost_id
      t.integer :user_id
      t.string :pr
    end
  end
end
