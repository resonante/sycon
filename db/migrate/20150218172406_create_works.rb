class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.belongs_to :customer
      t.string :name
      t.string :address
      t.text :description
      t.datetime :date

      t.timestamps null: false
    end
  end
end
