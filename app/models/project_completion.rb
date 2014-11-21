class ProjectCompletion < ActiveRecord::Base
  include UrlValidations

  belongs_to :project
  belongs_to :user

  validates_presence_of :url, :project, :user

  validates_uniqueness_of :url,     scope: :project_id
  validates_uniqueness_of :user_id, scope: :project_id

  def completed?
    project.criteria.pluck(:id).all? do |criterion_id|
      criteria_completion[criterion_id.to_s].to_bool
    end
  end
end
