module ::Concerns::User::GithubApiMethods
  extend ActiveSupport::Concern

  def repos
    self.github_api.repos.all
  rescue
    [ OpenStruct.new(html_url: '', name: 'Unable to connect to your GitHub repos!') ]
  end

  def github_api
    @github_api ||= Github.new(
      oauth_token: self.github_token,
      user: self.username
    )
  end

end