class Notification::TopicReply < Notification::Base
  belongs_to :reply,:class_name=>Rforum::Reply
end
