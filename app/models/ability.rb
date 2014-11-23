class Ability
  include CanCan::Ability
  include ::Concerns::Ability::Admin
  include ::Concerns::Ability::Instructor
  include ::Concerns::Ability::Mentor
  include ::Concerns::Ability::Student
  include ::Concerns::Ability::Anonymous

  attr_accessor :user

  def initialize(user)
    @user = user

    if user
      if    user.admin?      then admin_abilities
      elsif user.instructor? then instructor_abilities
      elsif user.mentor?     then mentor_abilities
      else                        student_abilities
      end
    else
      anonymous_abilities
    end
  end

private

  def admin_abilities
    instructor_abilities

    admin_course_abilities
  end

  def instructor_abilities
    mentor_abilities

    instructor_course_abilities
    instructor_skill_abilities
    instructor_resource_abilities
    instructor_html_abilities
  end

  def mentor_abilities
    student_abilities

    mentor_course_abilities
  end

  def student_abilities
    anonymous_abilities

    student_skill_abilities
    student_resource_abilities
    student_project_abilities
    student_project_completion_abilities
  end

  def anonymous_abilities
    anonymous_course_abilities
    anonymous_skill_abilities
    anonymous_resource_abilities
    anonymous_project_abilities
    anonymous_project_completion_abilities
  end

end
