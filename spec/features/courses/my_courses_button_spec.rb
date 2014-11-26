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