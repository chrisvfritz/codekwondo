class Ability
  include CanCan::Ability

  attr_accessor :user

  def initialize(user)
    @user = user

    if user
      if user.admin?
        admin
      elsif user.instructor?
        instructor
      elsif user.mentor?
        mentor
      else
        student
      end
    else
      anonymous
    end
  end

private

  def admin
    instructor

    can :manage, :all
  end

  def instructor
    mentor

    can :create, Course
    can :update, Course do |course|
      course.maintainer_id == user.id
    end
    can :create, Skill do |skill|
      skill.course.maintainer_id == user.id
    end
    can :update, Skill do |skill|
      skill.mainainer_id == user.id
    end
    can :sort_skills_for, Course do |course|
      course.maintainer_id == user.id
    end
  end

  def mentor
    student
  end

  def student
    anonymous

    can :create, Resource
    can :update, Resource do |resource|
      resource.maintainer_id == user.id
    end
    can :vote_on, Resource
  end

  def anonymous
    can :read, [Course, Skill, Resource]
  end
end
