class CreatePurchaseOrderItems < ActiveRecord::Migration
  def change
    create_table :purchase_order_items do |t|
      t.belongs_to :purchase_order
      t.integer :item
      t.text :description
      t.string :unit
      t.decimal :quantity, default: 0 
      t.decimal :price, default: 0
      t.timestamps null: false
    end
  end
end
