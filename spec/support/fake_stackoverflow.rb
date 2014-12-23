require 'sinatra/base'

class FakeStackoverflow < Sinatra::Base

  get '/:api_version/users/:ids/questions' do
    json_response 200, 'users_questions.json'
  end

  get '/:api_version/similar' do
    json_response 200, 'users_questions.json'
  end

private

  def json_response(response_code, file_name)
    content_type :json
    status response_code
    File.open(File.dirname(__FILE__) + '/fixtures/stackoverflow/' + file_name, 'rb').read
  end
end