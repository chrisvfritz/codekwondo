FactoryGirl.define do

  factory :language do
    name   { |n| "Language Title #{n}" }
    abbrev { |n| 'Language Title'.split(' ').map{|w| w[0]}.join + n.to_s }
  end

end