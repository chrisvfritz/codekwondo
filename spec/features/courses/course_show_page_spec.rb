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

    context 'in the table skill row' do

      before(:each) do
        signin
        @user = User.first
        @user.update_columns(username: '-!student')
        @user_skills  = create_list(:skill, 3, creator: @user, course: @course)
        visit course_path(@course)
      end

      context 'when the user is the creator of the skill' do

        context 'there are NO project completions for the skill' do

          it 'should show an edit button for the skill' do
            @user_skills.each do |skill|
              within "#skill_#{skill.id}" do
                expect(page).to have_link( 'Edit', edit_skill_path(skill) )
              end
            end
          end

          it 'should show a delete button for the skill' do
            @user_skills.each do |skill|
              within "#skill_#{skill.id}" do
                expect(page).to have_link( 'Delete', skill_path(skill) )
              end
            end
          end

        end

        context 'there are project completions for the skill' do

          before(:each) do
            @completed_skill = @user_skills.first
            create :project_completion, project: create(:project, skill: @completed_skill)
            visit course_path(@course)
          end

          it 'should NOT show an edit button for the skill' do
            within "#skill_#{@completed_skill.id}" do
              expect(page).not_to have_link( 'Edit', edit_skill_path(@completed_skill) )
            end
          end

          it 'should NOT show a delete button for the skill' do
            within "#skill_#{@completed_skill.id}" do
              expect(page).not_to have_link( 'Delete', skill_path(@completed_skill) )
            end
          end

        end

      end

      context 'when the user is NOT the creator of the skill' do

        before(:each) do
          @other_skills = create_list :skill, 3, course: @course
          visit course_path(@course)
        end

        it 'should NOT show an edit button for the skill' do
          @other_skills.each do |skill|
            within "#skill_#{skill.id}" do
              expect(page).not_to have_link( 'Edit', edit_skill_path(skill) )
            end
          end
        end

        it 'should NOT show a delete button for the skill' do
          @other_skills.each do |skill|
            within "#skill_#{skill.id}" do
              expect(page).not_to have_link( 'Delete', skill_path(skill) )
            end
          end
        end

      end

    end

  end

end