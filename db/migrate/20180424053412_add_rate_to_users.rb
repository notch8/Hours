class AddRateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :rate, :decimal, :precision => 8, :scale => 2 
  end
end
