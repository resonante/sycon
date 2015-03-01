class CreatePurchaseOrderItems < ActiveRecord::Migration
  def change
    create_table :purchase_order_items do |t|
      t.belongs_to :purchase_order
      t.integer :item
      t.text :description
      t.string :unit
      t.decimal :quantity
      t.decimal :price
      t.timestamps null: false
    end
  end
end
