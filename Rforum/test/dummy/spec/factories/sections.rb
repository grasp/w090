FactoryGirl.define do
  factory :section ,:class => Rforum::Section  do
    sequence(:name){|n| "name#{n}" }
  end
end
