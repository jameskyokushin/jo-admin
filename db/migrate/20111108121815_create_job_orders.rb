class CreateJobOrders < ActiveRecord::Migration
  def self.up
    create_table :job_orders do |t|
      t.string :company_name
      t.string :contact_person
      t.string :address
      t.string :contact_number
      t.string :system
      t.string :technical1
      t.string :technical2
      t.string :category
      t.string :status
      t.text :todo
      t.text :work_done
      t.text :remarks

      t.timestamps
    end
  end

  def self.down
    drop_table :job_orders
  end
end
