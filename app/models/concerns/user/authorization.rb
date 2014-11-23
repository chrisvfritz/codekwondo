module ::Concerns::User::Authorization
  extend ActiveSupport::Concern

  # -----------
  # DEFINITIONS
  # -----------

  ADMIN_LIST = [
    '-!admin', # mock with invalid username for testing
    'chrisvfritz'
  ]

  INSTRUCTOR_LIST = [
    '-!instructor' # mock with invalid username for testing
  ]

  MENTOR_LIST = [
    '-!mentor' # mock with invalid username for testing
  ]

  # ------
  # CHECKS
  # ------

  def admin?
    ADMIN_LIST.include?(username)
  end

  def instructor?
    INSTRUCTOR_LIST.include?(username) || self.admin?
  end

  def mentor?
    MENTOR_LIST.include?(username) || self.instructor? || self.admin?
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