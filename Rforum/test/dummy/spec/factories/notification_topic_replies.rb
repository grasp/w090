FactoryGirl.define do
  factory :notification_topic_reply, :class => Ruser::Notification::TopicReply, :parent => :notification_base do
    association :reply
  end
end
