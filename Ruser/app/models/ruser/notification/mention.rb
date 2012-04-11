class Ruser::Notification::Mention < Ruser::Notification::Base
  belongs_to :reply,:class_name=>"Rforum::Reply"
end
