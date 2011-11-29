class AddPreparedbyToJobOrders < ActiveRecord::Migration
  def self.up
    add_column :job_orders, :prepared_by, :string
  end

  def self.down
    remove_column :job_orders, :prepared_by
  end
end
