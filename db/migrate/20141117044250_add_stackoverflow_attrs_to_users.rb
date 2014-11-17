class AddStackoverflowAttrsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :stackoverflow_omniauth_hash, :text
    add_column :users, :stackoverflow_id,            :integer
    add_column :users, :stackoverflow_url,           :string
  end
end
