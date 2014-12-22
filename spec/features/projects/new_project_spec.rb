feature 'New project form' do

  before(:each) do
    User.destroy_all
    signin
    @skill = create(:skill)
  end

  context 'when student is signed in' do

    before(:each) do
      visit new_skill_project_path(@skill)
    end

    it 'should display an unauthorized message' do
      expect(page).to have_content('You are not authorized to access this page.')
    end

    it 'should redirect to the root url' do
      expect(current_path).to eq(root_path)
    end

  end

  context 'when mentor is signed in' do

    before(:each) do
      User.first.update_column(:username, '-!mentor')
      visit new_skill_project_path(@skill)
    end

    it 'should have a title input' do
      within 'form#new_project' do
        expect(page).to have_css('input#project_title')
      end
    end

    it 'should have a description textarea' do
      within 'form#new_project' do
        expect(page).to have_css('textarea#project_description')
      end
    end

    it 'should have a single criterion texarea' do
      within 'form#new_project .nested-fields' do
        expect(page).to have_css('textarea[id*="project_criteria_attributes"]', count: 1)
      end
    end

    it 'should have a remove criterion button for the criterion text area' do
      within 'form#new_project .nested-fields' do
        expect(page).to have_link('remove criterion')
      end
    end

    it 'should have an add criterion button' do
      within 'form#new_project .nested-fields + .links' do
        expect(page).to have_link('add criterion')
      end
    end

    describe 'add criterion button', js: true do

      before(:each) do
        click_link 'add criterion'
      end

      it 'should add a new criterion field' do
        expect(page).to have_css('textarea[id*="project_criteria_attributes"]', count: 2)
      end

      it 'should add a remove criterion button for each new criterion field' do
        expect(page).to have_css('a.remove_fields', count: 2)
      end

    end

    describe 'remove criterion button', js: true do

      before(:each) do
        click_link 'remove criterion'
      end

      it 'should remove the criterion field immediately preceding it' do
        expect(page).not_to have_css('textarea[id*="project_criteria_attributes"]')
      end

    end

  end

end