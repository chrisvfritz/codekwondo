class ProjectCompletionsController < ApplicationController
  load_and_authorize_resource

  before_action :set_completion, only: [:show, :edit, :update, :destroy, :screenshot]
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

  def screenshot
    authorize! :read, ProjectCompletion

    default_capture_size = 1170
    default_thumbnail_size = 200

    image = IMGKit.new(@completion.url,
      width: params[:width] || default_capture_size,
      height: params[:height] || default_capture_size,
      quality: params[:quality] || ((default_thumbnail_size.to_f / default_capture_size) * 100).ceil,
      'disable-smart-width' => true
    ).to_img(params[:format].to_sym)

    respond_to do |format|
      format.jpg { send_data image, type: 'image/jpeg', disposition: 'inline' }
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
    params.require(:project_completion).permit(:url, :github_repo_url).merge(criteria_completion: criteria_completion)
  end

end