module ::Concerns::Ability::Anonymous

  def anonymous_course_abilities
    can :read, ::Course
  end

  def anonymous_skill_abilities
    can :read, ::Skill
  end

  def anonymous_resource_abilities
    can :read, ::Resource
  end

  def anonymous_project_abilities
    can :read, ::Project
  end

  def anonymous_project_completion_abilities
    can :read, ::ProjectCompletion

    can :screenshot, ::ProjectCompletion
  end

end