class Notification::Mention < Notification::Base
  belongs_to :reply,:class_name=>"Rforum::Reply"
end
