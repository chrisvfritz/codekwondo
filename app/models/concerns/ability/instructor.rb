module ::Concerns::Ability::Instructor

  def instructor_course_abilities
    can :update, ::Course
  end

  def instructor_skill_abilities
    can :update, ::Skill
  end

  def instructor_resource_abilities
    can [:update, :destroy], ::Resource do |resource|
      resource.creator == user
    end
  end

  def instructor_html_abilities
    can :include_html_in, :markdown
  end

end