feature 'Homepage' do

  context 'when there are NO featured courses' do

    it 'displays a message saying no courses' do
      visit root_path

      expect(page).to have_content('No courses found.')
    end

  end

  context 'when there ARE featured courses' do

    before :each do
      @featured_courses = create_list :course, 3, :featured
      @non_featured_courses = create_list :course, 3
      visit root_path
    end

    it 'displays a table with links to the featured courses' do
      within '#courses_table' do
        @featured_courses.each do |course|
          expect(page).to have_link(course.title, href: course_path(course))
        end
      end
    end

    it 'shows featured courses in a dag', js: true do
      within '#dag' do
        @featured_courses.each do |course|
          expect(page).to have_css("circle[data-original-title='#{course.title}']")
        end
      end
    end

    it 'does NOT display non-featured courses' do
      within '#courses_table' do
        @non_featured_courses.each do |course|
          expect(page).not_to have_link(course.title)
        end
      end
    end

    context 'when the current user is an instructor' do
      before(:each) do
        signin
        user = User.first
        user.update_columns(username: '-!instructor')
        visit root_path
      end

      it 'the courses should NOT be sortable' do
        within '#courses_table' do
          expect(page).not_to have_css('tbody.sortable')
        end
      end
    end

    context 'when the current user is an admin' do
      before(:each) do
        signin
        user = User.first
        user.update_columns(username: '-!admin')
        visit root_path
      end

      it 'the courses should be sortable' do
        within '#courses_table' do
          expect(page).to have_css('tbody.sortable')
        end
      end
    end

  end

end