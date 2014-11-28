feature 'Skill show page' do

  before(:each) do
    @skill = create :skill
  end

  context 'when NO user is signed in' do

    before(:each) do
      visit skill_path(@skill)
    end

    it 'should NOT have a link to create a new resource' do
      expect(page).not_to have_link('', href: new_skill_resource_path(@skill))
    end

    it 'should NOT have a link to create a new project' do
      expect(page).not_to have_link('', href: new_skill_project_path(@skill))
    end

  end

  context 'when a user is signed in' do

    before(:each) do
      signin
      visit skill_path(@skill)
    end

    it 'should have a link to create a new resource' do
      expect(page).to have_link('', href: new_skill_resource_path(@skill))
    end

    context 'but is NOT the creator of the skill' do

      before(:each) do
        @other_skill = create :skill, creator: create(:user)
      end

      it 'should NOT have a link to create a new project' do
        expect(page).not_to have_link('', href: new_skill_project_path(@other_skill))
      end

    end

    context 'and is the creator of the skill' do

      it 'should have a link to create a new project' do
        expect(page).to have_link('', href: new_skill_project_path(@skill))
      end

    end

    it 'should navigate to a new resource form when you click on a new link' do
      find("a[href='#{new_skill_resource_path(@skill)}']").click
      expect(page).to have_content('New resource')
    end

  end

end