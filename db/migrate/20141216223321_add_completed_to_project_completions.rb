class AddCompletedToProjectCompletions < ActiveRecord::Migration
  def up
    add_column :project_completions, :completed, :boolean
    add_index  :project_completions, :completed

    ProjectCompletion.find_each do |completion|
      completion.update_completed_status
    end
  end

  def down
    remove_column :project_completions, :completed
  end
end
