class AddMoneyToMicroposts < ActiveRecord::Migration[5.1]
  def change
    add_column :microposts, :money, :integer
    add_column :microposts, :start_time, :date
    add_column :microposts, :end_time, :date
  end
end
