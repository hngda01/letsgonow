class AddPictureToDistricts < ActiveRecord::Migration[5.1]
  def change
    add_column :districts, :picture, :string
  end
end
