class AddReadOnlyToSkills < ActiveRecord::Migration
  def change
    add_column :skills, :read_only, :boolean, default: false
  end
end
