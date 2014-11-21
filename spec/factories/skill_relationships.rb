FactoryGirl.define do

  factory :skill_relationship do
    association :skill,  factory: :skill
    association :prereq, factory: :skill
  end

end