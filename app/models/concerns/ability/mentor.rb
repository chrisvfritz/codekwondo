module ::Concerns::Ability::Mentor

  def mentor_course_abilities
    # courses can be created
    can :create, ::Course

    # courses can be updated or sorted by their creators
    can [:update, :sort_skills_for], ::Course do |course|
      course.creator == user
    end

    # courses can be destroyed by their creator if no one has started a project for them
    can :destroy, ::Course do |course|
      course.creator == user && ProjectCompletion.where(project_id: course.skills.map{|skill| skill.projects.pluck(:id)}.flatten).none?
    end
  end

  def mentor_project_abilities
    can :create, ::Project
  end

  def mentor_project_completion_abilities
    can :review, ::ProjectCompletion
  end

end