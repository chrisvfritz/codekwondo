OmniAuth.config.test_mode = true

OmniAuth.config.add_mock :github, OmniAuth::AuthHash.new({
  provider: 'github',
  uid: '123545',
  info: {
    name: 'Mock User',
    email: 'mockuser@example.com',
    nickname: 'mockuser',
    image: 'http://example.com/path/to/my/image.jpg',
    urls: {
      'GitHub' => 'http://github.com/mockuser'
    }
  },
  credentials: {
    token: ''
  }
})

OmniAuth.config.add_mock :stackexchange, OmniAuth::AuthHash.new({
  provider: 'stackexchange',
  uid: '123545',
  info: {
    nickname: 'Mock Student',
    email: 'mockstudent@example.com',
    image: 'http://example.com/path/to/my/image.jpg',
    urls: {
      'stackoverflow' => 'http://stackoverflow.com/users/123545/mock-student'
    }
  }
})