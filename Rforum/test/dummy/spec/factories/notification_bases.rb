FactoryGirl.define do
  factory :notification_base, :class => Ruser::Notification::Base do
    association :user
  end
end
