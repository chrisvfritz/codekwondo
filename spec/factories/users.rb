FactoryGirl.define do

  factory :user do
    provider 'github'
    uid '123545'
    name 'Mock User'
    username 'mockuser'
    email 'mockuser@example.com'
    image_url 'http://example.com/path/to/my/image.jpg'
    github_url 'http://github.com/mockuser'

    trait(:mentor)     { username '-!mentor'     }
    trait(:instructor) { username '-!instructor' }
    trait(:admin)      { username '-!admin'      }

    trait :with_stackoverflow_id do
      stackoverflow_id { rand(1637442) }
    end
  end

end