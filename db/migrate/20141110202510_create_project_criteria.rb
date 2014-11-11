class CreateProjectCriteria < ActiveRecord::Migration
  def change
    create_table :project_criteria do |t|
      t.integer :project_id
      t.text :description

      t.timestamps
    end
  end
end
