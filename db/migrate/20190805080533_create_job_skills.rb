class CreateJobSkills < ActiveRecord::Migration[5.1]
  def change
    create_table :job_skills do |t|
      t.string :skill
      t.integer :micropost_id
    end
  end
end
