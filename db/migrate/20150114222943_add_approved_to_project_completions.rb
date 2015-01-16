class AddApprovedToProjectCompletions < ActiveRecord::Migration
  def change
    add_column :project_completions, :approved, :boolean, default: false
  end
end
