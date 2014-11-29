feature 'Stack Overflow connect button' do

  context 'when NOT signed in' do

    it 'does NOT display connect stack overflow button' do
      visit root_path

      within '#navbar_links' do
        expect(page).not_to have_link('Connect Stack Overflow')
      end
    end

  end

  context 'when signed in' do

    context 'but stack overflow has NOT been connected' do

      before(:each) do
        signin
        visit root_path
      end

      it 'displays connect stack overflow button' do
        within '#navbar_links' do
          expect(page).to have_link('Connect Stack Overflow')
        end
      end

      it 'successfully connects to stack overflow' do
        click_link 'Connect Stack Overflow'
        expect(page).not_to have_link('Connect Stack Overflow')
      end

    end

    context 'and stack overflow HAS been connected' do

      it 'does NOT display connect stack overflow button' do
        signin
        User.first.update_attributes(stackoverflow_id: 1)

        visit root_path

        within '#navbar_links' do
          expect(page).not_to have_link('Connect Stack Overflow')
        end
      end

    end

  end

end