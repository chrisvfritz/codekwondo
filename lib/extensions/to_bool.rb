module Extensions::ToBool

  def to_bool(nil_value = false)
    compare_value = self.class == String ? self.downcase : self
    case compare_value
    when "no","false",false, "0", 0 then false
    when "yes","true",true, "1", 1  then true
    when nil                        then nil_value
    else                                 !!compare_value
    end
  end

  def is_bool?(nil_value = false)
    compare_value = self.class == String ? self.downcase : self
    case compare_value
    when "no","false",false, "0", 0 then true
    when "yes","true",true, "1", 1  then true
    when nil                        then nil_value
    else                                 false
    end
  end

end