class CourseRelationship < ActiveRecord::Base
  belongs_to :course
  belongs_to :prereq, class_name: 'Course'

  validates_presence_of :course, :prereq

  validates_uniqueness_of :course_id, scope: :prereq_id

  validate :is_acyclic

  def is_acyclic
    if course == prereq
      errors.add(:base, "A course can't be a prerequisite to itself")
      return false
    end

    check_for_course = Proc.new do |current_course|
      if course == current_course
        errors.add(:base, "Catch 22 detected. \"#{course.title}\" is already required before \"#{prereq.title}\".")
        return false
      end

      current_course.prereqs.each do |course_to_check|
        check_for_course.call course_to_check
      end
    end

    check_for_course.call prereq
    return true
  end
end
