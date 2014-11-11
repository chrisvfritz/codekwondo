OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github,
    Rails.application.secrets[:omniauth][:github][:key],
    Rails.application.secrets[:omniauth][:github][:secret],
    scope: 'user:email'
end