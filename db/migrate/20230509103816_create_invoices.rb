class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.integer :serial_number, null: false
      t.string :name
      t.integer :amount
      t.index :serial_number
      t.timestamps
    end
  end
end
