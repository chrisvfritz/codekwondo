feature 'New project completion form' do
  before(:each) do
    signin
    @user = User.first
    @project = create :project, :with_criteria
    visit new_project_project_completion_path(@project)
  end

  context 'when the user has a working GitHub token' do

    it 'displays the user\'s public GitHub repos in the Github Repo select' do
      within '#project_completion_github_repo_url' do
        @user.repos.each do |repo|
          expect( page.find("option[value='#{repo.url}']:last-child") ).to have_content(repo.title)
        end
      end
    end

    it 'should list the project\'s criteria with checkboxes, defaulted to unchecked' do
      within '#new_project_completion' do
        @project.criteria.each do |criterion|
          expect( page.find("#project_completion_criteria_completion_#{criterion.id}") ).not_to be_checked
        end
      end
    end

  end

  context 'when a criterion checkbox' do

    before(:each) do
      @criterion = @project.criteria.first
    end

    context 'when a criterion checkbox is left UNchecked' do
      it 'should record that criterion as UNcompleted' do
        click_button 'Save showcase'
        expect( find("#project_completion_criteria_completion_#{@criterion.id}") ).not_to be_checked
      end
    end

    context 'when a criterion checkbox is checked' do
      it 'should record that criterion as completed' do
        check @criterion.description
        click_button 'Save showcase'
        expect( find("#project_completion_criteria_completion_#{@criterion.id}") ).to be_checked
      end
    end

  end
end