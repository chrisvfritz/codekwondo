# Where we download our gems from
source 'https://rubygems.org'

# The ruby version we're using
ruby '2.1.2'

# ESSENTIALS
gem 'rails', '4.1.5' # The version of rails we're running
gem 'pg'             # We're using the Postgresql (PG) database
gem 'unicorn'        # Use unicorn as the app server

# AR EXTENSIONS
gem 'acts_as_list'
gem 'paper_trail', '~> 3.0.6'
gem 'acts_as_votable', '~> 0.10.0'

# MISC
gem 'rest-client', '~> 1.7.2'

# TEMPLATING
gem 'slim-rails', require: 'slim/logic_less'                           # Use slim for HTML templates (with logic-less mode for presentations)
gem 'jbuilder', '~> 2.0'                                               # Build JSON APIs with ease
gem 'simple_form', '~> 3.1.0.rc2', github: 'plataformatec/simple_form' # Simplifies form building
gem 'cocoon', '~> 1.2.6'                                               # Simplifies dynamic, nested forms
gem 'gretel', '~> 3.0.8'                                               # Simplifies breadcrumbing

# ASSET PREPARATION
gem 'sass-rails', '~> 4.0.3'   # Use SCSS for stylesheets
gem 'coffee-rails', '~> 4.0.0' # Use CoffeeScript for .js.coffee assets and views
gem 'uglifier', '>= 1.3.0'     # Use Uglifier as compressor for JavaScript assets
gem 'autoprefixer-rails'       # Adds browser vendor prefixes automatically

# ASSET LIBRARIES
gem 'bootstrap-sass', '~> 3.3.0' # Include Twitter Bootstrap
gem 'jquery-rails'               # Include the jQuery JavaScript library
gem 'jquery-ui-rails'            # Include the jQuery UI JavaScript library
gem 'chosen-rails', '~> 1.2.0'   # Include the jQuery Chosen library
gem 'codemirror-rails', '~> 4.4' # Include the CodeMirror JavaScript library

# AUTHENTICATION
gem 'omniauth'
gem 'omniauth-github'

# AUTHORIZATION
gem 'cancancan', '~> 1.9'

# DOCUMENTATION
group :doc do
  gem 'sdoc', '~> 0.4.0' # bundle exec rake doc:rails generates the API under doc/api.
end

# DEVELOPMENT
group :development do
  gem 'spring'            # Spring speeds up development by keeping your application running in the background
  gem 'bullet'            # Helps to kill N+1 queries and unused eager loading
  gem 'better_errors'     # Gives MUCH better errors in development
  gem 'binding_of_caller' # Necessary for better_error's REPL
  gem 'pry-rails'         # Uses pry for the rails console
  gem 'colorize'          # Provides easier-to-parse rake output
  # gem 'rack-mini-profiler' # Gives a performance breakdown in development
end

# TESTING - For example setup, see http://www.webascender.com/Blog/ID/566/Testing-Rails-4-Apps-With-RSpec-3-Part-I#.VEUZxZPF-0w
group :development, :test do
  gem 'spring-commands-rspec'
  gem 'rspec-rails', '~> 3.0.0' # Use rspec for testing
  gem 'capybara'                # Use capybara to
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'guard-rspec'        # Watches our app for changes, to automatically and selectively run tests
  gem 'rb-fsevent' if `uname` =~ /Darwin/
end

# NOTES
# - Turbolinks comes with Rails 4. You can remove it with http://blog.steveklabnik.com/posts/2013-06-25-removing-turbolinks-from-rails-4