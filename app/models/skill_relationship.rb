class SkillRelationship < ActiveRecord::Base
  belongs_to :skill
  belongs_to :prereq, class_name: 'Skill'

  validate :is_acyclic

  def is_acyclic
    if skill == prereq
      errors.add(:base, "A skill can't be a prerequisite to itself")
      return false
    end

    check_for_skill = Proc.new do |current_skill|
      if skill == current_skill
        errors.add(:base, "Catch 22 detected. \"#{skill.title}\" is already required before \"#{prereq.title}\".")
        return false
      end

      current_skill.prereqs.each do |skill_to_check|
        check_for_skill.call skill_to_check
      end
    end

    check_for_skill.call prereq
    return true
  end
end
