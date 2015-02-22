class CreateAgents < ActiveRecord::Migration
  def change
    create_table :agents do |t|
      t.belongs_to :costumer
      t.string :name
      t.string :email

      t.timestamps null: false
    end
  end
end
