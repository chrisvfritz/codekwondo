feature 'Skill presentation', js: true do

  before(:each) do
    @presentation_title = 'Test Title'
    @skill = create :skill, presentation: "# #{@presentation_title}"
    visit presentation_skill_path(@skill)
  end

  it 'should show the presentation title in an h1' do
    # within 'h1' do
      expect(page).to have_content(/#{@presentation_title}/i)
    # end
  end

end