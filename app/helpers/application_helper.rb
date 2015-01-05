module ApplicationHelper

  # ---------
  # BOOTSTRAP
  # ---------

  def bootstrap_alert_class_for(flash_type)
    case flash_type.to_sym
      when :notice        then 'alert-info'
      when :error, :alert then 'alert-danger'
      else "alert-#{flash_type}"
    end
  end

  def md_to_html(markdown, creator)
    renderer = creator.can?(:include_html_in, :markdown) ? TRUSTED_MARKDOWN : MARKDOWN
    renderer.render(markdown).html_safe
  end

  def skill_class(skill)
    return 'read_only'   if skill.read_only
    return 'in_progress' if skill.projects.none?
    return 'completed'   if user_signed_in? && @completed_skills.include?(skill)
    ''
  end

end