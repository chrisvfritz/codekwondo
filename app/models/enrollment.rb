class Enrollment < ActiveRecord::Base
  belongs_to :section
  belongs_to :user

  scope :completed_project, ->(project_or_id) {
    project_id = case project_id_id
    when Integer then project_or_id
    when Project then project_or_id.id
    else raise TypeError, 'completed project only accepts a project id (Integer) or project (Project)'
    end

    ProjectCompletion.where(project: project).completed
  }

  def full_name
    self.first_name + ' ' + self.last_name
  end
end
