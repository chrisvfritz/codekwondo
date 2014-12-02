require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'shoulda/matchers'
require 'capybara/rails'
require 'capybara/rspec'

if ENV['SAUCY']
  require 'sauce'
  require 'sauce/capybara'

  Capybara.javascript_driver = :sauce

  Sauce.config do |config|
    config[:browsers] = [
      ['Linux', 'Chrome', nil],
      ['Linux', 'Firefox', nil]
    ]
  end
end

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  config.before(:each) do
    allow_any_instance_of(User).to receive(:repos).and_return([
      OpenStruct.new(html_url: 'https://github.com/mockuser/repo1', name: 'repo_1'),
      OpenStruct.new(html_url: 'https://github.com/mockuser/repo2', name: 'repo_2')
    ])
    allow_any_instance_of(Skill).to receive(:create_gist).and_return(false)
    allow_any_instance_of(Skill).to receive(:update_gist).and_return(false)
  end
end
