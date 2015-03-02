class CreatePurchaseOrders < ActiveRecord::Migration
  def change
    create_table :purchase_orders do |t|
      t.belongs_to :customer
      t.belongs_to :supplier
      t.belongs_to :work
      t.string :reference
      t.text :description
      t.date :issue_date
      t.date :begin_date
      t.date :due_date
      t.timestamps null: false
    end
  end
end
