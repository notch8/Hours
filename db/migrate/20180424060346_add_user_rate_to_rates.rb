class AddUserRateToRates < ActiveRecord::Migration
  def change
    add_column :rates, :user_rate, :decimal, :precision => 8, :scale => 2 
  end
end
