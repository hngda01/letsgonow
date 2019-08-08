class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :address
      t.string :hobby
      t.string :date_of_birth
      t.string :phone_number

      t.timestamps
    end
  end
end
