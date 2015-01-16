class ProjectCompletion < ActiveRecord::Base
  include UrlValidations

  STAMP_OF_APPROVAL = /:\+1:/

  belongs_to :project
  belongs_to :user

  scope :completed,   -> { where(completed: true ) }
  scope :uncompleted, -> { where(completed: false) }

  scope :reviewed,   -> { select { |completion|  completion.reviewed? } }
  scope :unreviewed, -> { select { |completion| !completion.reviewed? } }

  scope :approved,   -> { select { |completion|  completion.approved? } }
  scope :unapproved, -> { select { |completion| !completion.approved? } }

  # scope :awaited, -> {
  #   select do |completion|
  #     Assignment.includes(:session_assigned, :session_due).where('session_assigned.start_time > ? AND sessions_due.end_time < ?', )
  #     Assignment.where('sessi') {|a| a.session_due.start_time < Time.now }
  #     Session.where(course_id: completion.project.skill.course.id)
  #     # implement assignments
  #   end
  # }

  validates_presence_of :url, :github_repo_url, :project, :user

  validates_uniqueness_of :url, scope: :project_id
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

    Rails.cache.fetch("github_issue: #{username}, repo: #{github_repo}, version: 2", expires_in: 30.minutes, force: options[:force]) do
      self.user.github_api.get_request("repos/#{username}/#{github_repo}/issues?state=all").body
    end
  end

  def reviewed?
    review.to_bool
  end

  def review
    @review ||= github_issues.find do |issue|
      User.mentors.pluck(:username).include?(issue.user.login) &&
        issue.title =~ /review/i
    end
  end

  def review_url
    review['html_url']
  end

  def approved?
    return true if self.approved

    approved_on_github = reviewed? &&
      ( review.body =~ STAMP_OF_APPROVAL ||
          ( review.comments > 0 &&
              self.user.github_api.get_request(review.comments_url).any? do |comment|
                User.mentors.pluck(:username).include?(comment.user.login) &&
                  comment.body =~ STAMP_OF_APPROVAL
              end
          )
      )

    approve if approved_on_github

    self.approved
  end

  def approve
    self.update_column(:approved, true)
  end

  def github_new_issue_url
    @github_new_issue_url ||= self.github_repo_url + '/issues/new'
  end

  def github_repo
    @github_repo ||= self.github_repo_url.scan(/https:\/\/github\.com\/#{self.user.username}\/(.+)/)[0][0]
  end

end