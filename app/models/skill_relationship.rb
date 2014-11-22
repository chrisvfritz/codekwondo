class SkillRelationship < ActiveRecord::Base
  PREREQ_MODEL = 'skill'
  include PrereqValidations

  belongs_to :skill
  belongs_to :prereq, class_name: 'Skill'

  validates_presence_of :skill, :prereq

  validates_uniqueness_of :skill_id, scope: :prereq_id
end
