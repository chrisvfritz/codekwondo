module User::Authorization
  extend ActiveSupport::Concern

  # -----------
  # DEFINITIONS
  # -----------

  ADMIN_LIST = [
    'chrisvfritz'
  ]

  INSTRUCTOR_LIST = []

  MENTOR_LIST = []

  # ------
  # CHECKS
  # ------

  def admin?
    ADMIN_LIST.include? username
  end

  def instructor?
    INSTRUCTOR_LIST.include? username
  end

  def mentor?
    MENTOR_LIST.include? username
  end

  def mastered_skills
    project_completions.includes(:project).select{|p| p.completed?}.map{|p| p.project.skill}.uniq
  end

  # -------
  # QUERIES
  # -------

  included do
    scope :admins,      -> { where(username: ADMIN_LIST) }
    scope :instructors, -> { where(username: ADMIN_LIST + INSTRUCTOR_LIST) }
    scope :mentors,     -> { where(username: ADMIN_LIST + INSTRUCTOR_LIST + MENTOR_LIST) }
    scope :students,    -> { where.not(username: ADMIN_LIST + INSTRUCTOR_LIST + MENTOR_LIST)}
  end

end