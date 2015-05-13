class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.decimal :iva
      t.decimal :islr
      t.decimal :rl
      t.decimal :rfc
      t.timestamps null: false
    end
  end
end
