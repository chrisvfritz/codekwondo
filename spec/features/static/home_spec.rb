feature 'Homepage' do

  before :each do
    visit root_path
  end

  it 'should welcome the user' do
    expect(page).to have_content 'Welcome'
  end

end
