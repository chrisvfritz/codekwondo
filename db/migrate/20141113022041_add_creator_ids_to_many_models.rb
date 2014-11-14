class AddCreatorIdsToManyModels < ActiveRecord::Migration
  def change
    add_column :skills,    :creator_id, :integer
    add_column :resources, :creator_id, :integer
    add_column :projects,  :creator_id, :integer
  end
end
