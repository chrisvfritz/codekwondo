class ProjectCriterion < ActiveRecord::Base
  belongs_to :project

  validates_presence_of :description
end
