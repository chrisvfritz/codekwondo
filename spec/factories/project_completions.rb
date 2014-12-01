FactoryGirl.define do

  factory :project_completion do
    url { |n| "http://www.google.com/?#{URI::encode(n.to_s)}" }
    github_repo_url { |n| "https://github.com/mockuser/repo?#{URI::encode(n.to_s)}" }
    association :project, factory: :project
    association :user,    factory: :user

    trait :completed do
      after(:build) do |completion|
        completion.criteria_completion = Hash[
            *completion.project.criteria.map do |criterion|
              [criterion.id, true]
            end.flatten
          ]
      end
    end
  end

end