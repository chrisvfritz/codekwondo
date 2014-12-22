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
require 'capybara/poltergeist'

Capybara.javascript_driver = :poltergeist

require_relative 'support/capybara'
require_relative 'support/database_cleaner'
require_relative 'support/factory_girl'
require_relative 'support/omniauth'
require_relative 'support/helpers/omniauth_helpers'
require_relative 'support/helpers'

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
