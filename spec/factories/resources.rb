FactoryGirl.define do

  factory :resource do
    title { |n| "Resource Title #{n}" }
    url { |n| "http://www.google.com/?#{URI::encode(n.to_s)}" }
    association :skill,   factory: :skill
    association :creator, factory: :user
  end

end