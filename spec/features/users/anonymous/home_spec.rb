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

    it 'does NOT display non-featured courses' do
      within '#courses_table' do
        @non_featured_courses.each do |course|
          expect(page).not_to have_link(course.title)
        end
      end
    end

  end

end