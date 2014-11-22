module ::Concerns::Ability::Admin

  def admin_course_abilities
    can :sort, Course do |*courses|
      courses.count > 1 &&
        courses.map(&:id).sort == Course.featured.ids.sort
    end
  end

end