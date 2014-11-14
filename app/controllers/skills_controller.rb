class SkillsController < ApplicationController
  load_and_authorize_resource except: [:presentation]

  before_action :set_skill,  only: [:edit, :update, :destroy, :presentation]
  before_action :set_course, only: [:new, :create, :sort]

  def show
    @skill = Skill.includes(projects: [:creator, :criteria, :completions], resources: :creator).find(params[:id])
  end

  def new
    @skill = @course.skills.build
  end

  def edit
  end

  def create
    @skill = @course.skills.build skill_params.merge(creator_id: current_user.id)

    respond_to do |format|
      if @skill.save
        format.html { redirect_to @skill, notice: 'Skill was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @skill.update(skill_params)
        format.html { redirect_to @skill, notice: 'Skill was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @skill.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Skill was successfully deleted.' }
    end
  end

  def sort
    params[:skill].each_with_index do |id, index|
      Skill.where(id: id).update_all(position: index+1)
    end
    render nothing: true
  end

  def presentation
    authorize! :read, @skill
    render inline: ERB.new(Slim::ERBConverter.new(logic_less: true).call(@skill.presentation.to_s)).result, layout: 'presentation'
  end

private

  def set_skill
    @skill = Skill.find(params[:id])
  end

  def set_course
    @course = Course.find(params[:course_id])
  end

  def skill_params
    params.require(:skill).permit(:title, :presentation, :primary_language_id, prereq_ids: [])
  end
end
