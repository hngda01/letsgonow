class AddYearsToUserSkills < ActiveRecord::Migration[5.1]
  def change
    add_column :user_skills, :years, :integer
  end
end
