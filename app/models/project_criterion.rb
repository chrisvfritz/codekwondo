class ProjectCriterion < ActiveRecord::Base
  belongs_to :project

  validates_presence_of :description, :project_id

  validates_uniqueness_of :description, scope: :project_id
end
