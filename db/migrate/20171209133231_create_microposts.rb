class CreateMicroposts < ActiveRecord::Migration[5.0]
  def change
    create_table :microposts do |t|
      t.text :title
      t.text :content
      t.boolean :accept, default: false
      t.string :picture

      t.references :user, foreign_key: true
      t.references :district, foreign_key: true
      t.timestamps
    end
    add_index :microposts, [:user_id, :created_at]
  end
end