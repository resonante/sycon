class CreateValuations < ActiveRecord::Migration
  def change
    create_table :valuations do |t|
   	  t.belongs_to :purchase_order
   	  t.text :title
      t.text :description
      t.integer :reference
      t.string :invoice
      t.timestamps null: false
    end
  end
end
