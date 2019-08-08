class CreateSliders < ActiveRecord::Migration[5.1]
  def change
    create_table :sliders do |t|
      t.string :picture
      t.timestamps
    end
  end
end
