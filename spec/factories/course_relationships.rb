FactoryGirl.define do

  factory :course_relationship do
    association :course, factory: :course
    association :prereq, factory: :course
  end

end