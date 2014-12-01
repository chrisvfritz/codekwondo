module ::Concerns::Ability::Student

  def student_profile_abilities
    # users can see their own profiles
    can :show_profile_for, User do |current_user|
      current_user == user
    end
  end

  def student_skill_abilities
    # skills can be created by people who created the course
    can :create, ::Skill do |skill|
      skill.course.creator == user
    end

    # skills can be updated or destroyed by their creator if no one has started a project for them
    can [:update, :destroy], ::Skill do |skill|
      skill.creator == user && ProjectCompletion.where(project_id: skill.projects.pluck(:id)).none?
    end
  end

  def student_resource_abilities
    # all students can create or vote on resources
    can [:create, :vote_on], ::Resource

    # resource can be updated by a user if they're the only one to have voted on it
    can :update, ::Resource do |resource|
      resource.votes_for.count == 1 && user.liked?(resource)
    end

    # resource can be destroyed if it has a rating of less than 10 and the user created the course
    can :destroy, ::Resource do |resource|
      resource.rating < 10 && resource.creator == user
    end
  end

  def student_project_abilities
    # project can be created by the creator of its skill
    can :create, ::Project do |project|
      project.skill.creator == user
    end

    # project can be created by the creator of its skill
    can :create_project_for, ::Skill do |skill|
      skill.creator == user
    end

    # project can be updated or destroyed by the project creator if no one has started it
    can [:update, :destroy], ::Project do |project|
      project.creator == user && project.completions.none?
    end
  end

  def student_project_completion_abilities
    # any user can create a project completion
    can :create, ::ProjectCompletion

    # project completion can be updated or destroyed by its user
    can [:update, :destroy], ::ProjectCompletion do |completion|
      completion.user == user
    end
  end

end