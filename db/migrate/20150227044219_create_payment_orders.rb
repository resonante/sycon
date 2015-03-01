class CreatePaymentOrders < ActiveRecord::Migration
  def change
    create_table :payment_orders do |t|
      t.text :description
      t.timestamps null: false
    end
  end
end
