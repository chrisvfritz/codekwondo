FactoryGirl.define do

  factory :project do
    title { |n| "Mock title #{n}" }
    description 'This is a mock description.'
    association :skill,   factory: :skill
    association :creator, factory: :user

    after(:build) do |project|
      project.criteria << build(:project_criterion)
    end
  end

end