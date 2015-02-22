class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.belongs_to :work
      t.string :name
      t.string :email
      t.text :description

      t.timestamps null: false
    end
  end
end
