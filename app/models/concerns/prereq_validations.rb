module PrereqValidations
  extend ActiveSupport::Concern

  included do
    validate :is_acyclic
  end

  def is_acyclic
    return errors.add(:base, "A self can't be a prerequisite to itself") if self.send(self.class::PREREQ_MODEL) == self.prereq

    check_for_self = Proc.new do |current_self|
      return errors.add(:base, "Catch 22 detected. \"#{self.send(self.class::PREREQ_MODEL).title}\" is already required before \"#{self.prereq.title}\".") if self.send(self.class::PREREQ_MODEL) == current_self

      current_self.prereqs.each { |self_to_check| check_for_self.call(self_to_check) }
    end

    check_for_self.call self.prereq
  end
end