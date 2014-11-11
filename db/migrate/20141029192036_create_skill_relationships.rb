class CreateSkillRelationships < ActiveRecord::Migration
  def change
    create_table :skill_relationships do |t|
      t.integer :prereq_id
      t.integer :skill_id

      t.timestamps
    end

    add_index :skill_relationships, [:prereq_id, :skill_id], unique: true, name: 'by_skill_prereq_direction'
  end
end
