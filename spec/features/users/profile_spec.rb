feature 'User portfolio' do

  before(:each) do
    signin
    @user = User.first
  end

  context 'when the user has NOT completed any courses' do

    before(:each) { visit user_profile_path }

    it 'should tell the user they have NOT completed any courses yet' do
      expect(page).to have_content("You haven't completed any courses yet.")
    end

  end

  context 'when the user has completed courses' do

    before(:each) do
      @completed_course = create(:course, creator: @user)
      skill = create :skill, course: @completed_course
      project = create :project, :with_criteria, skill: skill
      create :project_completion, :completed, project: project, user: @user

      @other_course = create(:course, creator: @user)

      visit user_profile_path
    end

    it 'should list the completed courses' do
      within '#completed_courses' do
        expect(page).to have_content(@completed_course.title)
      end
    end

    it 'should NOT list UNcompleted courses' do
      within '#completed_courses' do
        expect(page).not_to have_content(@other_course.title)
      end
    end

  end

  context 'when the user has NOT completed a project for a skill' do

    before(:each) { visit user_profile_path }

    it 'should tell the user they have NOT mastered any skills yet' do
      expect(page).to have_content("You haven't mastered any skills yet.")
    end

  end

  context 'when the user has completed a project for a skill' do

    before(:each) do
      course = create(:course, creator: @user)
      @completed_skill = create :skill, course: course
      project = create :project, :with_criteria, skill: @completed_skill
      create :project_completion, :completed, project: project, user: @user

      @other_skill = create(:skill, course: course)

      visit user_profile_path
    end

    it 'should list mastered skills' do
      within '#completed_skills' do
        expect(page).to have_link(@completed_skill.title)
      end
    end

    it 'should NOT list UNmastered skills' do
      within '#completed_skills' do
        expect(page).not_to have_link(@other_skill.title)
      end
    end

  end

end