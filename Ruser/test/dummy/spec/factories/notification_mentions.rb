FactoryGirl.define do
  factory :notification_mention, :class => Ruser::Notification::Mention, :parent => :notification_base do
    association :reply
  end
end
