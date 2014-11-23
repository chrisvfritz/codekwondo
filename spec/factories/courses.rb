FactoryGirl.define do

  factory :course do
    title  { |n| "Course Title #{n}" }
    abbrev { |n| 'Course Title'.split(' ').map{|w| w[0]}.join + n.to_s }
    association :creator, factory: :user

    trait :featured do
      featured true
    end
  end

end