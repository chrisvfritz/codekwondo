class Enrollment < ActiveRecord::Base
  belongs_to :section
  belongs_to :user

  scope :with_user, -> {
    where.not(user_id: nil)
  }

  scope :without_user, -> {
    where(user_id: nil)
  }

  scope :without_completed_project, ->(project_or_id) {
    project_id = case project_or_id
    when Integer then project_or_id
    when Project then project_or_id.id
    when String  then project_or_id.to_i
    else raise TypeError, 'completed project only accepts a project id (Integer) or project (Project)'
    end

    # Enrollment.includes(user: :project_completi.where(user: { project_completions: { project_id: project_id, completed: true }})
    Enrollment.includes(user: :project_completions).all.select do |enrollment|
      enrollment.user.project_completions.none? do |completion|
        completion.project_id == project_id && completion.completed
      end
    end
  }

  def full_name
    self.first_name + ' ' + self.last_name
  end
end
