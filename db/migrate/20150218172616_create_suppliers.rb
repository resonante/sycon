class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
      t.belongs_to :work
      t.string :name
      t.string :email
      t.text :address
      t.text :description

      t.timestamps null: false
    end
  end
end
