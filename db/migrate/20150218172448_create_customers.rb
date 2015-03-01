class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email
      t.text :address
      t.string :phone
      t.string :mobile
      t.string :state
      t.string :town
      t.text :description

      t.timestamps null: false
    end
  end
end
