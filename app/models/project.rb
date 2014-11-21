class Project < ActiveRecord::Base
  belongs_to :creator, class_name: 'User'
  belongs_to :skill

  has_many :criteria, class_name: 'ProjectCriterion'
  accepts_nested_attributes_for :criteria, reject_if: :all_blank, allow_destroy: true

  has_many :completions, class_name: 'ProjectCompletion'

  validates_presence_of :title, :description, :criteria, :creator, :skill
  validates_uniqueness_of :title, scope: :skill_id
end
