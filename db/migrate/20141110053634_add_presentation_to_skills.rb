class AddPresentationToSkills < ActiveRecord::Migration
  def change
    add_column :skills, :presentation, :text
  end
end
