class ChangeUserRateToAmount < ActiveRecord::Migration
  def change
    rename_column :rates, :user_rate, :amouht
    rename_column :users, :rate, :base_amount
  end
end
