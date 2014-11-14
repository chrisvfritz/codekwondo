class User < ActiveRecord::Base
  include ::Concerns::User::Authorization

  has_many :created_courses,   class_name: 'Course',   foreign_key: 'creator_id'
  has_many :created_skills,    class_name: 'Skill',    foreign_key: 'creator_id'
  has_many :created_resources, class_name: 'Resource', foreign_key: 'creator_id'
  has_many :created_projects,  class_name: 'Project',  foreign_key: 'creator_id'

  has_many :project_completions

  acts_as_voter

  def self.from_omniauth(auth)
    where( provider: auth.provider, uid: auth.uid ).first_or_create do |user|
      user.provider   = auth.provider
      user.uid        = auth.uid
      user.username   = auth.info.nickname
      user.name       = auth.info.name
      user.email      = auth.info.email
      user.image_url  = auth.info.image
      user.github_url = auth.info.urls.GitHub
    end
  end

  def completed_courses
    completed_skill_ids = Project.where( id: project_completions.select(:project_id) ).pluck(:skill_id)
    Course.select{|course| course.skills.pluck(:id).all?{|skill_id| completed_skill_ids.include?(skill_id) }}
  end
end
