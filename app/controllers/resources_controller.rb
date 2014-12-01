class ResourcesController < ApplicationController
  load_and_authorize_resource :skill
  load_and_authorize_resource :resource, through: :skill, shallow: true, except: [:upvote, :downvote]

  before_action :set_resource, only: [:edit, :update, :destroy, :upvote, :downvote]
  before_action :set_skill,    only: [:new, :create]

  def new
    @course_id = session[:resources_bookmarklet_course_id] = params[:course_id] if params[:course_id]
    @resource = @skill.present? ? @skill.resources.build : Resource.new
  end

  def edit
  end

  def create
    is_from_bookmarklet = @course_id = session[:resources_bookmarklet_course_id]
    params[:skill_id] ||= params[:resource][:skill]
    @resource = @skill.present? ? @skill.resources.build(resource_params.merge(creator_id: current_user.id)) : Resource.new(resource_params.merge(creator_id: current_user.id))

    respond_to do |format|
      if @resource.save
        session.delete(:resources_bookmarklet_course_id)
        current_user.likes @resource
        format.html do
          if is_from_bookmarklet
            redirect_to @resource.url
          else
            redirect_to @resource.skill, notice: 'Resource was successfully created.'
          end
        end
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @resource.update(resource_params)
        format.html { redirect_to @resource.skill, notice: 'Resource was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @resource.destroy
    respond_to do |format|
      format.html { redirect_to skill_url(@resource.skill), notice: 'Resource was successfully deleted.' }
    end
  end

  def upvote
    authorize! :vote_on, @resource
    current_user.likes @resource
    redirect_to @resource.skill
  end

  def downvote
    authorize! :vote_on, @resource
    current_user.dislikes @resource
    redirect_to @resource.skill
  end

private

  def set_resource
    @resource = Resource.find(params[:id])
  end

  def set_skill
    @skill = Skill.find(params[:skill_id]) if params[:skill_id]
  end

  def resource_params
    params.require(:resource).permit(:title, :url, :paid, :price, :skill_id)
  end
end