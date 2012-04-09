FactoryGirl.define do
  factory :location ,:class => Ruser::Location do
    sequence(:name){|n| "name#{n}" }
  end
end
