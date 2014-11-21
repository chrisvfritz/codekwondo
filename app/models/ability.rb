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

    can :sort, Course do |*courses|
      courses.count > 1 &&
        courses.map(&:id).sort == Course.featured.ids.sort
    end
  end

  def instructor
    mentor

    can [:update, :destroy], Resource do |resource|
      resource.creator == user
    end

    can :update, [Course, Skill]

    can :include_html_in, :markdown
  end

  def mentor
    student
  end

  def student
    anonymous

    # anyone can create a course
    can :create, Course
    # courses can be updated or sorted by their creators
    can [:update, :sort_skills_for], Course do |course|
      course.creator == user
    end
    # courses can be destroyed by their creator if no one has started a project for them
    can :destroy, Course do |course|
      course.creator == user && ProjectCompletion.where(project_id: course.skills.map{|skill| skill.projects.pluck(:id)}.flatten).none?
    end

    # skills can be created by people who created the course
    can :create, Skill do |skill|
      skill.course.creator == user
    end
    # skills can be updated or destroyed by their creator if no one has started a project for them
    can [:update, :destroy], Skill do |skill|
      skill.creator == user && ProjectCompletion.where(project_id: skill.projects.pluck(:id)).none?
    end

    # all students can create or vote on resources
    can [:create, :vote_on], Resource
    # resource can be updated by a user if they're the only one to have voted on it
    can :update, Resource do |resource|
      resource.votes_for.count == 1 && resource.liked_by?(user)
    end
    # resource can be destroyed if it has a rating of less than 10 and the user created the course
    can :destroy, Resource do |resource|
      resource.rating < 10 && resource.creator == user
    end

    # project can be created by the creator of its course
    can :create, Project do |project|
      project.skill.course.creator == user
    end
    # project can be updated or destroyed by the project creator if no one has started it
    can [:update, :destroy], Project do |project|
      project.creator == user && project.completions.none?
    end

    # any user can create a project completion
    can :create, ProjectCompletion
    # project completion can be updated or destroyed by its user
    can [:update, :destroy], ProjectCompletion do |completion|
      completion.user == user
    end
  end

  def anonymous
    can :read, [Course, Skill, Resource, Project, ProjectCompletion]
    can :screenshot, ProjectCompletion
  end
end
