class User < ActiveRecord::Base
  include ::Concerns::User::Authentication
  include ::Concerns::User::Authorization
  include ::Concerns::User::Validations
  include ::Concerns::User::Stackoverflow
  include ::Concerns::User::GithubApiMethods

  serialize :github_omniauth_hash,        Hash
  serialize :stackoverflow_omniauth_hash, Hash

  has_many :enrollments

  has_many :created_courses,   class_name: 'Course',   foreign_key: 'creator_id'
  has_many :created_skills,    class_name: 'Skill',    foreign_key: 'creator_id'
  has_many :created_resources, class_name: 'Resource', foreign_key: 'creator_id'
  has_many :created_projects,  class_name: 'Project',  foreign_key: 'creator_id'

  has_many :project_completions

  acts_as_voter

  def completed_courses
    completed_skill_ids = Project.where( id: self.project_completions.select{ |c| c.completed? }.map(&:project_id) ).pluck(:skill_id)

    Course.select do |course|
      course.skills.any? && course.skills.pluck(:id).all? do |skill_id|
        completed_skill_ids.include? skill_id
      end
    end
  end

end
