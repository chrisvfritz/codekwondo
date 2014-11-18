class ProjectsController < ApplicationController
  load_and_authorize_resource :skill
  load_and_authorize_resource :project, through: :skill, shallow: true

  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :set_skill, only: [:new, :create]

  def show
  end

  def new
    @project = @skill.projects.build
    @project.criteria.build
  end

  def edit
  end

  def create
    @project = @skill.projects.build project_params.merge(creator_id: current_user.id)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @skill, notice: 'Resource was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project.skill, notice: 'Project was successfully updated.' }
      else
        @project.criteria.each{|criterion| criterion.reload if criterion.marked_for_destruction?}
        format.html { render :edit }
      end
    end
  end

  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Project was successfully deleted.' }
    end
  end

private

  def set_project
    @project = Project.find(params[:id])
  end

  def set_skill
    @skill = Skill.find(params[:skill_id])
  end

  def project_params
    params.require(:project).permit(:title, :description, criteria_attributes: [:id, :description, :_destroy])
  end

end