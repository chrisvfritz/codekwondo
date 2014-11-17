class AddGithubOmniauthHashToUsers < ActiveRecord::Migration
  def change
    add_column :users, :github_omniauth_hash, :text
  end
end
