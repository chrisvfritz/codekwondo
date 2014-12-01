class ProjectCompletion < ActiveRecord::Base
  include UrlValidations

  belongs_to :project
  belongs_to :user

  validates_presence_of :url, :github_repo_url, :project, :user

  validates_uniqueness_of :url,             scope: :project_id
  validates_uniqueness_of :github_repo_url, scope: :project_id
  validates_uniqueness_of :user_id,         scope: :project_id

  validate :github_repo_belongs_to_user

  def completed?
    project.criteria.pluck(:id).all? do |criterion_id|
      criteria_completion[criterion_id.to_s].to_bool
    end
  end

  def github_repo_belongs_to_user
    return unless errors.blank? # only run when all other validations pass
    errors.add(:base, "That's odd. This repo doesn\'t belong to you. Suspicious activity has been logged.") unless self.github_repo_url =~ /https:\/\/github.com\/#{self.user.username}\//
  end
end