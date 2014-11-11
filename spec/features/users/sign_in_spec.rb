feature 'Sign in', :omniauth do

  before :each do
    signout
  end

  it 'succeeds with valid account' do
    signin
    expect(page).to have_link('Sign out')
  end

  it 'fails with invalid account' do
    # Setup
    old_mock = OmniAuth.config.mock_auth[:github]
    OmniAuth.config.mock_auth[:github] = :invalid_credentials

    # Testing
    visit root_path
    expect(page).to have_link('Sign in')
    click_link 'Sign in'
    expect(page).to have_content('Authentication error')

    # Cleanup
    OmniAuth.config.mock_auth[:github] = old_mock
  end

end