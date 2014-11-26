feature 'New course form' do

  context 'when only a student is signed in' do

    before(:each) do
      signin
      visit courses_path
    end

    it 'should redirect to root' do
      expect(page).to have_xpath(root_path)
    end

    it 'should display a not authorized message' do
      expect(page).to have_text('You are not authorized to access this page.')
    end

  end

  context 'when a mentor is signed in' do

    before(:each) do
      signin
      @user = User.first
      @user.update_columns(username: '-!mentor')
    end

    context 'when no other courses exist' do

      before(:each) do
        visit new_course_path
      end

      it 'should NOT have a prereqs field' do
        expect(page).not_to have_css('#course_prereq_ids')
      end

      context 'when submitted empty' do

        before(:each) do
          click_button 'Create Course'
        end

        it 'should show a can\'t be blank message for title' do
          within '.form-group.course_title' do
            expect(page).to have_content('can\'t be blank')
          end
        end

        it 'should show a can\'t be blank message for abbreviation' do
          within '.form-group.course_abbrev' do
            expect(page).to have_content('can\'t be blank')
          end
        end

      end

      context 'when filled in with valid data and submitted' do

        before(:each) do
          @course_title  = 'Gar! My new title!'
          @course_abbrev = 'CRS1'
          # @prereq_title  = 'Test Prereq'

          # create :course, title: @prereq_title

          fill_in 'course[title]', with: @course_title
          fill_in 'course[abbrev]', with: @course_abbrev
          click_button 'Create Course'
        end

        it 'should have created a new course with the appropriate attributes' do
          expect( Course.where(title: @course_title, abbrev: @course_abbrev).count ).to eq(1)
        end

        it 'should redirect to the new course\'s show page' do
          course = Course.find_by(title: @course_title, abbrev: @course_abbrev)
          expect(current_path).to eq( course_path(course) )
        end

        it 'should show a message course created message' do
          expect(page).to have_content('Course was successfully created.')
        end

      end

    end

    context 'when other courses exist' do

      before(:each) do
        @courses = create_list :course, 3
        visit new_course_path
      end

      it 'should have a prereqs field' do
        expect(page).to have_css('#course_prereq_ids')
      end

      it 'should have other courses prepopulated as options of prerequisites' do
        within '#course_prereq_ids' do
          @courses.each do |course|
            expect( page.find("option[value='#{course.id}']") ).to have_content(course.title)
          end
        end
      end

      context 'when filled in with valid data and submitted' do

        before(:each) do
          @course_title  = 'Gar! My new title!'
          @course_abbrev = 'CRS1'
          @course_prereq = @courses.first

          fill_in 'course[title]', with: @course_title
          fill_in 'course[abbrev]', with: @course_abbrev
          select @course_prereq.title, from: 'course[prereq_ids][]'

          click_button 'Create Course'
        end

        it 'should have created a new course with the appropriate attributes' do
          course_query = Course.where(title: @course_title, abbrev: @course_abbrev)
          expect( course_query.count ).to eq(1)
          expect( course_query.first.prereqs ).to include(@course_prereq)
        end

        it 'should redirect to the new course\'s show page' do
          course = Course.find_by(title: @course_title, abbrev: @course_abbrev)
          expect(current_path).to eq( course_path(course) )
        end

        it 'should show a message course created message' do
          expect(page).to have_content('Course was successfully created.')
        end

      end

    end

  end

end