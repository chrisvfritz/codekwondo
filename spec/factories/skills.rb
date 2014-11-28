FactoryGirl.define do

  factory :skill do
    title { |n| "Mock title #{n}" }
    presentation '# Test Presentation'
    association :creator, factory: :user
    association :course, factory: :course
    association :primary_language, factory: :language
  end

end