class RestrictSkillsToSingleCourse < ActiveRecord::Migration
  def change
    drop_table :course_skill_inclusions
  end
end
