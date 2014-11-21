FactoryGirl.define do

  factory :project_completion do
    url { |n| "http://www.google.com/?#{URI::encode(n.to_s)}" }
    association :project, factory: :project
    association :user,    factory: :user
  end

end