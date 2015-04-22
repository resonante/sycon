class CreateValuationItems < ActiveRecord::Migration
  def change
    create_table :valuation_items do |t|
      t.belongs_to :valuation
      t.belongs_to :purchase_order_item
      t.decimal :value, default: 0
      t.timestamps null: false
    end
  end
end
