FactoryGirl.define do
  factory :topic,:class => Rforum::Topic do
    title 'title'
    body 'body'
    association :user
    association :node
  end
end
