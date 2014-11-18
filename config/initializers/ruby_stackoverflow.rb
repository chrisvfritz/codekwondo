# If there are any admins that have authorized Stack Overflow, then
# use their access token to raise the 300 request cap on API calls

begin

  if ( authorized_admins = User.admins.where.not(stackoverflow_omniauth_hash: {}).limit(1) ).any?

    RubyStackoverflow.configure do |config|
      config.client_key   = Rails.application.secrets[:omniauth][:stackexchange][:key]
      config.access_token = authorized_admins.first.stackoverflow_omniauth_hash['credentials']['token']
    end

  end

rescue

  Rails.logger.info('WARNING: Skipping Stack Overflow API configuration')

end