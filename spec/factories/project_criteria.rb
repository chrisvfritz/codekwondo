FactoryGirl.define do

  factory :project_criterion do
    description { |n| "Mock description #{n}" }
    association :project, factory: :project
  end

end