class CreateCourseRelationships < ActiveRecord::Migration
  def change
    create_table :course_relationships do |t|
      t.integer :prereq_id
      t.integer :course_id

      t.timestamps
    end

    add_index :course_relationships, [:prereq_id, :course_id], unique: true, name: 'by_course_prereq_direction'
  end
end