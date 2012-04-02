class AddDateIssuedToJobOrders < ActiveRecord::Migration
  def self.up
    add_column :job_orders, :date_issued, :date
    add_column :job_orders, :date_finished, :date
  end

  def self.down
    remove_column :job_orders, :date_finished
    remove_column :job_orders, :date_issued
  end
end
