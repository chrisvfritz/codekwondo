RSpec.configure do |config|
  config.include Omniauth::SessionHelpers, type: :feature
end