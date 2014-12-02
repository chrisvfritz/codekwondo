module ApplicationHelper

  # ---------
  # BOOTSTRAP
  # ---------

  def bootstrap_class_for(flash_type)
    case flash_type.to_sym
      when :notice        then 'alert-info'
      when :success       then 'alert-success'
      when :error, :alert then 'alert-danger'
      else flash_type.to_s
    end
  end

  def md_to_html(markdown, creator)
    renderer = creator.can?(:include_html_in, :markdown) ? TRUSTED_MARKDOWN : MARKDOWN
    renderer.render(markdown).html_safe
  end

end