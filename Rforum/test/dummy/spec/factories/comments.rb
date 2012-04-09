FactoryGirl.define do
  factory :comment,:class => Rforum::Comment do
    body 'body'
    association :user
    commentable nil
  end
end
