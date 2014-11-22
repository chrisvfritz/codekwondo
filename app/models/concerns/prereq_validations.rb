module PrereqValidations
  extend ActiveSupport::Concern

  included do
    validate :is_acyclic
  end

  def is_acyclic
    if self.send(self.class::PREREQ_MODEL) == self.prereq
      return errors.add(self.class::PREREQ_MODEL, "A self can't be a prerequisite to itself")
    end

    check_for_self = Proc.new do |current_self|
      if self.send(self.class::PREREQ_MODEL) == current_self
        return errors.add(self.class::PREREQ_MODEL, "Catch 22 detected. \"#{self.send(self.class::PREREQ_MODEL).title}\" is already required before \"#{self.prereq.title}\".")
      end

      current_self.prereqs.each do |self_to_check|
        check_for_self.call self_to_check
      end
    end

    check_for_self.call self.prereq
  end
end