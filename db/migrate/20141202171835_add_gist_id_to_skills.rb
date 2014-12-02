class AddGistIdToSkills < ActiveRecord::Migration
  def change
    add_column :skills, :gist_id, :string
  end
end
