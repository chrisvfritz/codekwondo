class ProjectCompletion < ActiveRecord::Base
  include UrlValidations

  belongs_to :project
  belongs_to :user

  scope :completed,   -> { where(completed: true ) }
  scope :uncompleted, -> { where(completed: false) }

  scope :reviewed,   -> { select { |completion|  completion.reviewed? } }
  scope :unreviewed, -> { select { |completion| !completion.reviewed? } }

  validates_presence_of :url, :github_repo_url, :project, :user

  validates_uniqueness_of :url
  validates_uniqueness_of :github_repo_url
  validates_uniqueness_of :user_id, scope: :project_id

  validate :github_repo_belongs_to_user

  def github_repo_belongs_to_user
    return unless errors.blank? # only run when all other validations pass
    errors.add(:base, "That's odd. This repo doesn\'t belong to you. Suspicious activity has been logged.") unless self.github_repo_url =~ /https:\/\/github.com\/#{self.user.username}\//
  end

  after_save :update_completed_status

  def update_completed_status
    completed_status = self.project.criteria.pluck(:id).all? do |criterion_id|
      self.criteria_completion[criterion_id.to_s].to_bool
    end
    self.update_column(:completed, completed_status)
  end

  def github_issues(options={})
    username = self.user.username
    repo     = self.github_repo_url.scan(/https:\/\/github\.com\/#{username}\/(.+)/)[0][0]

    Rails.cache.fetch("github_issue: #{username}, repo: #{repo}, version: 1", expires_in: 30.minutes, force: options[:force]) do
      self.user.github_api.get_request("repos/#{username}/#{repo}/issues").body
    end
  end

  def reviewed?
    github_issues.any?{|repo| User.mentors.pluck(:username).include?(repo.user.login)}
  end

  def github_new_issue_url
    @github_new_issue_url ||= self.github_repo_url + '/issues/new'
  end

end