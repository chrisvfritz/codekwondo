class ModifyResourcesToFixFromCodingTooTired < ActiveRecord::Migration
  def change
    remove_column :resources, :title,    :integer
    remove_column :resources, :resource, :integer

    add_column :resources, :title,    :string
    add_column :resources, :skill_id, :integer
    add_column :resources, :url,      :string
  end
end
