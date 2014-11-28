class ProjectCriterion < ActiveRecord::Base
  belongs_to :project, inverse_of: :criteria

  validates_presence_of :description
  validates_presence_of :project

  validates_uniqueness_of :description, scope: :project_id
end
