class RemoveCreatorIdFromSkills < ActiveRecord::Migration
  def change
    remove_column :skills, :creator_id
  end
end
