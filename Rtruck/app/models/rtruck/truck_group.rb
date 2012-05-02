class Rtruck::TruckGroup
  include Mongoid::Document
  field :user_id, :type => String
  field :name, :type => String
end
