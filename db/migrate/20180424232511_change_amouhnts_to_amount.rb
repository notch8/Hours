class ChangeAmouhntsToAmount < ActiveRecord::Migration
  def change
    rename_column :rates, :amouht, :amount
  end
end
