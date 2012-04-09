FactoryGirl.define do
  factory :reply ,:class =>Rforum::Reply  do
    body 'body'
    association :user
    association :topic
  end
end
