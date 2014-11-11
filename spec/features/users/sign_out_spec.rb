feature 'Sign out', :omniauth do

  before :each do
    signout
  end

  it 'works and displays a message' do
    signin
    signout
    expect(page).to have_content 'Signed out'
  end

end