class User < ActiveRecord::Base
  include User::Authorization

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
