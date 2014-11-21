FactoryGirl.define do

  factory :project_criterion do
    description { |n| "Mock description #{n}" }
    project_id 1
  end

end