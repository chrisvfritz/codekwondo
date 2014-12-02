FactoryGirl.define do

  factory :skill do
    title { |n| "Mock title #{n}" }
    presentation '# Test Presentation'
    gist_id 'bc010e6ed25b802da7eb'
    association :creator, factory: :user
    association :course, factory: :course
    association :primary_language, factory: :language
  end

end