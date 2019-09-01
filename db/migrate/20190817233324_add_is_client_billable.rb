class AddIsClientBillable < ActiveRecord::Migration
  def change
    rename_column :timers, :billed, :is_client_billable
    add_column :hours, :is_client_billable, :boolean, default: true
  end
end
