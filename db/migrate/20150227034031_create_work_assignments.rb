class CreateWorkAssignments < ActiveRecord::Migration
  def change
    create_table :work_assignments do |t|
    	t.references :work, :agent
    	
    	t.timestamps null: false    	
    end
  end
end
