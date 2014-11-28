feature 'New resource bookmarklet' do

  before(:each) do
    signin
    @course = create :course
  end

  context 'NO course id is set' do

    before(:each) { visit new_resource_path }

    it 'should display a message saying a course id is required' do
      expect(page).to have_content('Course to save a resource for must be specified as a URL parameter.')
    end

  end

  context 'when a course id is set' do

    context 'when NO skills exist' do

      before(:each) { visit new_resource_path(course_id: @course.id) }

      it 'should display an error message saying that skills need to be added first' do
        expect(page).to have_content('Skills need to exist before resources can be saved.')
      end

    end

    context 'when skills exist' do

      before(:each) do
        @skills       = create_list :skill, 3, course: @course
        @other_skills = create_list :skill, 3
        visit new_resource_path(course_id: @course.id)
      end

      it 'should list all skills belonging to the course' do
        within '#resource_skill_id' do
          @skills.each do |course|
            expect( page.find("option[value='#{course.id}']") ).to have_content(course.title)
          end
        end
      end

      it 'should NOT list any skills NOT belonging to the course' do
        within '#resource_skill_id' do
          @other_skills.each do |course|
            expect{ page.find("option[value='#{course.id}']") }.to raise_exception(Capybara::ElementNotFound)
          end
        end
      end

      context 'after creating a valid new resource' do

        before(:each) do
          visit new_resource_path(
            course_id: @course.id,
            title: "It's google!",
            url: 'http://www.google.com/',
          )
          select @skills.first.title, from: 'Skill'
          click_button 'Create Resource'
        end

        it 'should redirect back to the URL just saved' do
          expect(current_url).to eq('http://www.google.com/')
        end

      end

    end

  end

end