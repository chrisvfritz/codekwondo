class ResourcesController < ApplicationController
  protect_from_forgery except: :bookmarklet
  load_and_authorize_resource

  before_action :set_resource, only: [:edit, :update, :destroy, :upvote, :downvote]
  before_action :set_skill,    only: [:new, :create]

  def new
    @resource = @skill.present? ? @skill.resources.build : Resource.new
  end

  def edit
  end

  def create
    is_from_bookmarklet = params[:resource][:skill].present?
    params[:skill_id] ||= params[:resource][:skill]
    @resource = @skill.present? ? @skill.resources.build(resource_params) : Resource.new(resource_params)

    respond_to do |format|
      if @resource.save
        current_user.likes @resource
        format.html { redirect_to (is_from_bookmarklet ? @resource.url : @resource.skill), notice: 'Resource was successfully created.' }
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
    current_user.likes @resource
    redirect_to @resource.skill
  end

  def downvote
    current_user.dislikes @resource
    redirect_to @resource.skill
  end

  def bookmarklet
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