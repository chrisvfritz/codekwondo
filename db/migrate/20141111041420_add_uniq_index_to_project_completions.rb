class AddUniqIndexToProjectCompletions < ActiveRecord::Migration
  def change
    add_index :project_completions, [:project_id, :user_id], unique: true, name: 'by_project_and_user'
  end
end
