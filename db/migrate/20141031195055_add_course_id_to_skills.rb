class AddCourseIdToSkills < ActiveRecord::Migration
  def change
    add_column :skills, :course_id, :integer
  end
end
