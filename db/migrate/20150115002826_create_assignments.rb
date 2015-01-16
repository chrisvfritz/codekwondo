class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :session_assigned_id
      t.integer :session_due_id
      t.integer :project_id

      t.timestamps
    end
  end
end
