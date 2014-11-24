OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github,
    Rails.application.secrets[:omniauth][:github][:key],
    Rails.application.secrets[:omniauth][:github][:secret],
    scope: 'user:email,gist,notifications'

  provider :stackexchange,
    Rails.application.secrets[:omniauth][:stackexchange][:id],
    Rails.application.secrets[:omniauth][:stackexchange][:secret],
    public_key: Rails.application.secrets[:omniauth][:stackexchange][:key],
    site: 'stackoverflow',
    scope: 'no_expiry,read_inbox'
end