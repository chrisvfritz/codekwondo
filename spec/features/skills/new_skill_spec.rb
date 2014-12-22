feature 'New skill form' do

  context 'when a student is signed in and is the creator of the course' do

    before(:each) do
      signin
      @course = create(:course, creator: User.first)
      visit course_path(@course)
    end

    context 'when no other skills exist' do

      before(:each) do
        visit new_course_skill_path(@course)
      end

      it 'should NOT have a prereqs field' do
        expect(page).not_to have_css('#skill_prereq_ids')
      end

      context 'when submitted empty' do

        before(:each) do
          click_button 'Create Skill'
        end

        it 'should show a can\'t be blank message for title' do
          within '.form-group.skill_title' do
            expect(page).to have_content('can\'t be blank')
          end
        end

        it 'should show a can\'t be blank message for primary language' do
          within '.form-group.skill_primary_language' do
            expect(page).to have_content('can\'t be blank')
          end
        end

      end

      context 'when filled in with valid data and submitted' do

        before(:each) do
          @skill_title  = 'Gar! My new title!'
          @primary_language = create(:language)

          visit new_course_skill_path(@course)

          fill_in 'skill[title]', with: @skill_title
          select @primary_language.name, from: 'skill[primary_language_id]'
          click_button 'Create Skill'
        end

        it 'should have created a new skill with the appropriate attributes' do
          expect( Skill.where(title: @skill_title, primary_language: @primary_language).count ).to eq(1)
        end

        it 'should redirect to the new skill\'s show page' do
          skill = Skill.find_by(title: @skill_title, primary_language: @primary_language)
          expect(current_path).to eq( skill_path(skill) )
        end

        it 'should show a skill created message' do
          expect(page).to have_content('Skill was successfully created.')
        end

      end

    end

    context 'when other skills exist' do

      before(:each) do
        @skills = create_list :skill, 3, course: @course
        visit new_course_skill_path(@course)
      end

      it 'should have a prereqs field' do
        expect(page).to have_css('#skill_prereq_ids')
      end

      it 'should have other skills prepopulated as options of prerequisites' do
        within '#skill_prereq_ids' do
          @skills.each do |skill|
            expect( page.find("option[value='#{skill.id}']") ).to have_content(skill.title)
          end
        end
      end

    end

  end

end