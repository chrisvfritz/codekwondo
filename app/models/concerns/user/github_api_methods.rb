module ::Concerns::User::GithubApiMethods
  extend ActiveSupport::Concern

  def repos
    self.github_api.repos.all
  rescue
    []
  end

private

  def github_api
    @github_api ||= Github.new(
      oauth_token: self.github_token,
      user: self.username,
      ssl: { verify: false }
    )
  end

end