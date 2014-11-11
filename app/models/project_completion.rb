class ProjectCompletion < ActiveRecord::Base
  include UrlValidations

  belongs_to :project
  belongs_to :user

  validates_presence_of :url

  def completed?
    project.criteria.pluck(:id).all? do |criterion_id|
      criteria_completion[criterion_id.to_s].to_bool
    end
  end
end
