feature 'My courses button' do

  context 'when NO user is signed in' do

    it 'should NOT appear' do
      visit root_path
      expect(page).not_to have_link('My Courses')
    end

  end

  context 'when a student is signed in' do

    it 'should NOT appear' do
      signin
      visit root_path
      expect(page).not_to have_link('My Courses')
    end

  end

  context 'when a mentor is signed in' do

    it 'should appear' do
      signin
      User.first.update_columns(username: '-!mentor')
      visit root_path
      expect(page).to have_link('My Courses')
    end

  end

end

feature 'Courses index' do

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

    it 'should list all of the current_user\'s courses' do
      user_courses = create_list :course, 2, creator: @user

      visit courses_path

      within '#courses_table' do
        user_courses.each do |course|
          expect(page).to have_link(course.title, course_path(course))
        end
      end
    end

    it 'should NOT list any courses not from this user' do
      create_list :course, 2, creator: @user
      other_courses = create_list :course, 2

      visit courses_path

      within '#courses_table' do
        other_courses.each do |course|
          expect(page).not_to have_link(course.title, course_path(course))
        end
      end
    end

    it 'should show a button to create a new course' do
      visit courses_path
      expect(page).to have_link('', href: new_course_path)
    end

  end

end