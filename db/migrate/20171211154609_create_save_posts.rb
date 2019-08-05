class CreateSavePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :save_posts do |t|
      t.references :user, foreign_key: true
      t.references :micropost, foreign_key: true
      t.timestamps
    end
    add_index :save_posts, [:user_id, :created_at]
  end
end
