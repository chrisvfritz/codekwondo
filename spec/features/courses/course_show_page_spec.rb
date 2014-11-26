feature 'Course show page' do

  it 'should have the name of the course in a breadcrumb' do
    course = create(:course)
    visit course_path(course)

    within '.breadcrumb' do
      expect(page).to have_content "Course: #{course.title}"
    end
  end

  it 'should have a bookmarklet notice' do
    course = create(:course)
    visit course_path(course)

    within '.alert' do
      expect(page).to have_content 'bookmarklet'
    end
  end

  context 'when NO skills for a course exist' do

    before(:each) do
      course = create(:course, skills: [])
      visit course_path(course)
    end

    it 'should not show an empty dag' do
      expect(page).not_to have_css('#dag')
    end

    it 'should show a message saying no skills' do
      expect(page).to have_content('No skills have been created yet.')
    end

  end

  context 'when skills for a course exist' do

    before(:each) do
      @course = create( :course, skills: create_list(:skill, 3) )
      visit course_path(@course)
    end

    it 'should show a dag with nodes for each skill', js: true do
      within '#dag' do
        @course.skills.each do |skill|
          expect(page).to have_css("circle[data-original-title='#{skill.title}']")
        end
      end
    end

    it 'should list each skill in a table' do
      within 'table#skills_table' do
        @course.skills.each do |skill|
          expect(page).to have_content(skill.title)
        end
      end
    end

  end

end