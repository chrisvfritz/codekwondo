class CourseRelationship < ActiveRecord::Base
  PREREQ_MODEL = 'course'
  include PrereqValidations

  belongs_to :course
  belongs_to :prereq, class_name: 'Course'

  validates_presence_of :course, :prereq

  validates_uniqueness_of :course_id, scope: :prereq_id
end
