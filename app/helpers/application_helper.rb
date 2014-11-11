module ApplicationHelper

  def bootstrap_class_for(flash_type)
    case flash_type.to_sym
      when :success then 'alert-success'
      when :error   then 'alert-danger'
      when :alert   then 'alert-block'
      when :notice  then 'alert-info'
      else flash_type.to_s
    end
  end

end