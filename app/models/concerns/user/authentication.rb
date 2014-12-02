module ::Concerns::User::Authentication
  extend ActiveSupport::Concern

  module ClassMethods

    def from_omniauth(auth)
      where( provider: auth.provider, uid: auth.uid ).first_or_create do |user|
        user.github_omniauth_hash = auth

        user.provider     = auth.provider
        user.uid          = auth.uid
        user.username     = auth.info.nickname
        user.name         = auth.info.name
        user.email        = auth.info.email
        user.image_url    = auth.info.image
        user.github_url   = auth.info.urls.GitHub
        user.github_token = auth.credentials.token
      end
    end

  end

end