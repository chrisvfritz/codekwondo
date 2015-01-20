class ProjectCompletionsController < ApplicationController
  load_and_authorize_resource :project_completion, except: [:index, :screenshot, :approve]

  before_action :set_completion, only: [:show, :edit, :update, :destroy, :screenshot, :approve]
  before_action :set_project, only: [:new, :create]

  ACCEPTABLE_SCREENSHOT_FORMATS = %w(jpg)

  def index
    authorize! :review, ProjectCompletion
    completed_completions = ProjectCompletion.includes(:user, :project).completed.order('updated_at ASC')
    @unreviewed_completions = completed_completions.select(&:unreviewed?)
    @unapproved_completions = completed_completions.select(&:reviewed?).select(&:unapproved?)
    # @enrollments_awaiting_completion
    # @enrollments_with_overdue_project
  end

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

    image_format = ACCEPTABLE_SCREENSHOT_FORMATS.include?(params[:format]) ? params[:format] : ACCEPTABLE_SCREENSHOT_FORMATS.first

    image = IMGKit.new(@completion.url,
      width: params[:width] || default_capture_size,
      height: params[:height] || default_capture_size,
      quality: params[:quality] || ((default_thumbnail_size.to_f / default_capture_size) * 100).ceil,
      'disable-smart-width' => true
    ).to_img(image_format.to_sym)

    send_data image, type: 'image/jpeg', disposition: 'inline'

    # For if I later accept any formats other than jpeg
    #
    # respond_to do |format|
    #   format.jpg { send_data image, type: 'image/jpeg', disposition: 'inline' }
    # end
  end

  def approve
    authorize! :review, ProjectCompletion
    @completion.approve

    respond_to do |format|
      format.html { redirect_to project_completions_path, notice: 'Showcase approved.' }
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
