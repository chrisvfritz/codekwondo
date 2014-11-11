class ProjectCompletionsController < ApplicationController
  load_and_authorize_resource

  before_action :set_completion, only: [:show, :edit, :update, :destroy]
  before_action :set_project, only: [:new, :create]

  def show
  end

  def new
    @completion = @project.completions.build
  end

  def edit
  end

  def create
    @completion = @project.completions.build project_completion_params.merge(user_id: current_user.id)

    respond_to do |format|
      if @completion.save
        format.html { redirect_to @project.skill, notice: 'Showcase was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @completion.update(project_completion_params)
        format.html { redirect_to @completion.project.skill, notice: 'Showcase was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @completion.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Showcase was successfully deleted.' }
    end
  end

private

  def set_completion
    @completion = ProjectCompletion.find(params[:id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def project_completion_params
    criteria_completion = params.require(:project_completion).fetch(:criteria_completion, nil).try(:permit!)
    params.require(:project_completion).permit(:url).merge(criteria_completion: criteria_completion)
  end

end