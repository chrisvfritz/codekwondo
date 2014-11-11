FactoryGirl.define do

  factory :user do
    provider 'twitter'
    uid '123545'
    name 'Mock User'
    email 'mockuser@example.com'
    image_url 'http://example.com/path/to/my/image.jpg'
    github_url 'http://github.com/mockuser'
  end

end