FactoryGirl.define do
  factory :node ,:class => Rforum::Node do
    sequence(:name){|n| "name#{n}" }
    section { |s| s.association(:section) }
    summary 'summary'
  end
end
