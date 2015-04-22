class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
      t.belongs_to :work
      t.string :name
      t.string :rif
      t.string :agent      
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
