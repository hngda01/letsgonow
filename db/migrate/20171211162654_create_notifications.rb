class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.string :notification
      t.references :user, foreign_key: true
      t.references :micropost, foreign_key: true
      t.timestamps
    end
    add_index :notifications, [:user_id, :created_at]
  end
end
