module ::Concerns::User::Validations
  extend ActiveSupport::Concern

  included do
    validates_presence_of :provider, :uid, :username, :name, :email, :image_url, :github_url
    validate :username_not_a_mock
  end

  def username_not_a_mock
    errors.add(:username, 'is already taken as a mock username') if username =~ /^-!/
  end
end