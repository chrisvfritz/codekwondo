module Extensions::ToBool

  def to_bool(nil_value = false)
    compare_value = self.class == String ? self.downcase : self
    case compare_value
    when 'no','false',false,'0',0,'' then return false
    when 'yes','true',true,'1',1     then return true
    when nil                         then return nil_value
    else                                  return !!compare_value
    end
  end

  def is_bool?(nil_value = false)
    compare_value = self.class == String ? self.downcase : self
    case compare_value
    when 'no','false',false,'0',0,'' then return true
    when 'yes','true',true,'1',1     then return true
    when nil                         then return nil_value
    else                                  return false
    end
  end

end