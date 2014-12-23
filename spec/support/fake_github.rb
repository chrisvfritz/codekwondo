require 'sinatra/base'

class FakeGithub < Sinatra::Base

  get '/user/repos' do
    json_response 200, 'user_repos.json'
  end

private

  def json_response(response_code, file_name)
    content_type :json
    status response_code
    File.open(File.dirname(__FILE__) + '/fixtures/github/' + file_name, 'rb').read
  end
end