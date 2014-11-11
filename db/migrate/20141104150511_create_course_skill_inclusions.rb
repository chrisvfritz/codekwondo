class CreateCourseSkillInclusions < ActiveRecord::Migration
  def change
    create_table :course_skill_inclusions do |t|
      t.integer :course_id
      t.integer :skill_id

      t.timestamps
    end

    add_index :course_skill_inclusions, [:course_id, :skill_id], unique: true, name: 'by_course_and_skill'
  end
end
