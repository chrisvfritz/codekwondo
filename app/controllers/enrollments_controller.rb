class EnrollmentsController < ApplicationController
  def index
    authorize! :review, ProjectCompletion
    @enrollments =  Enrollment.all.order(last_name: :asc)
    @project_id = params[:project_id]
  end
end