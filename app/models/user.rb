class User < ActiveRecord::Base
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

  def admin?
    [
      'chrisvfritz'
    ].include? username
  end

  def instructor?
    false
  end

  def mentor?
    false
  end

  def mastered_skills
    project_completions.includes(:project).select{|p| p.completed?}.map{|p| p.project.skill}.uniq
  end
end
