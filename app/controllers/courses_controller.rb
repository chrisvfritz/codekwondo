class CoursesController < ApplicationController
  load_and_authorize_resource

  before_action :set_course, only: [:show, :edit, :update, :destroy]

  def index
    @courses = Course.order('position ASC')
  end

  def show
    @skills = @course.skills.includes(:primary_language).order('position ASC')
  end

  def new
    @course = Course.new
  end

  def edit
  end

  def create
    @course = Course.new course_params

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully deleted.' }
    end
  end

  def sort
    params[:course].each_with_index do |id, index|
      Course.where(id: id).update_all(position: index+1)
    end
    render nothing: true
  end

private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:title, :abbrev, prereq_ids: [], skill_ids: [])
  end
end