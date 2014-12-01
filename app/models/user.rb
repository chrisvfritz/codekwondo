class User < ActiveRecord::Base
  include ::Concerns::User::Authorization
  include ::Concerns::User::Stackoverflow

  serialize :github_omniauth_hash,        Hash
  serialize :stackoverflow_omniauth_hash, Hash

  has_many :created_courses,   class_name: 'Course',   foreign_key: 'creator_id'
  has_many :created_skills,    class_name: 'Skill',    foreign_key: 'creator_id'
  has_many :created_resources, class_name: 'Resource', foreign_key: 'creator_id'
  has_many :created_projects,  class_name: 'Project',  foreign_key: 'creator_id'

  has_many :project_completions

  acts_as_voter

  validates_presence_of :provider, :uid, :username, :name, :email, :image_url, :github_url

  validate :username_not_a_mock

  def username_not_a_mock
    errors.add(:username, 'is already taken as a mock username') if username =~ /^-!/
  end

  def self.from_omniauth(auth)
    current_user = where( provider: auth.provider, uid: auth.uid ).first_or_create do |user|
      user.github_omniauth_hash = auth

      user.provider   = auth.provider
      user.uid        = auth.uid
      user.username   = auth.info.nickname
      user.name       = auth.info.name
      user.email      = auth.info.email
      user.image_url  = auth.info.image
      user.github_url = auth.info.urls.GitHub
    end

    # update the github_token if it has changed
    current_user.update_columns(github_token: auth.credentials.token) if auth.credentials.token != current_user.github_token

    current_user
  end

  def completed_courses
    completed_skill_ids = Project.where( id: self.project_completions.select{ |c| c.completed? }.map(&:project_id) ).pluck(:skill_id)

    Course.select do |course|
      course.skills.any? && course.skills.pluck(:id).all? do |skill_id|
        completed_skill_ids.include? skill_id
      end
    end
  end

  def repos
    self.github_api.repos.all
  rescue
    []
  end

  def github_api
    @github_api ||= Github.new(
      oauth_token: self.github_token,
      user: self.username,
      ssl: { verify: false }
    )
  end

end
