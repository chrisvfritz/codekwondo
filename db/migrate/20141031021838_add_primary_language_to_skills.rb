class AddPrimaryLanguageToSkills < ActiveRecord::Migration
  def change
    add_column :skills, :primary_language_id, :integer
  end
end
