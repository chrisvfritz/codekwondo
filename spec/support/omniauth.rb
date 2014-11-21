OmniAuth.config.test_mode = true

OmniAuth.config.add_mock :github, OmniAuth::AuthHash.new({
  provider: 'github',
  uid: '123545',
  info: {
    name: 'Mock Student',
    email: 'mockstudent@example.com',
    nickname: 'mockstudent',
    image: 'http://example.com/path/to/my/image.jpg',
    urls: {
      'GitHub' => 'http://github.com/mockstudent'
    }
  }
})