class AddGitubRepoUrlToProjectCompletions < ActiveRecord::Migration
  def change
    add_column :project_completions, :github_repo_url, :string
  end
end
