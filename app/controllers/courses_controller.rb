class CoursesController < ApplicationController
  load_and_authorize_resource

  before_action :set_course, only: [:show, :edit, :update, :destroy]

  def index
    authorize! :create, Course
    @courses = current_user.created_courses.includes(:creator, :skills).order(:title)
  end

  def show
    @skills = @course.skills.includes(:creator, :primary_language).order(:position)
    if user_signed_in?
      @completed_skills = @skills.includes(:projects).select do |skill|
        skill.projects.any? do |project|
          ( completion = project.completions.find_by(user_id: current_user.id) ) ? completion.completed? : false
        end
      end
      @approved_skills = @completed_skills.select do |skill|
        skill.projects.any? do |project|
          project.completions.find_by(user_id: current_user.id).approved?
        end
      end
    end
  end

  def new
    @course = Course.new
  end

  def edit
  end

  def create
    @course = Course.new course_params.merge(creator_id: current_user.id)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
      else
        format.html { render :new }
      end
    end

  rescue ActiveRecord::RecordInvalid => e
    flash[:error] = e.message
    render :new
  end

  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
      else
        format.html { render :edit }
      end
    end

  rescue ActiveRecord::RecordInvalid => e
    flash[:error] = e.message
    render :edit
  end

  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully deleted.' }
    end
  end

  def sort
    @courses = Course.where(id: params[:course])
    authorize! :sort, *@courses
    @courses.each do |course|
      course.update_attribute( :position, params[:course].index(course.id.to_s) + 1 )
    end
    render nothing: true
  end

private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:title, :abbrev, prereq_ids: [])
  end
end