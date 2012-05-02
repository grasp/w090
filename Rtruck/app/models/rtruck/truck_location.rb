# coding: utf-8
class Rtruck::TruckLocation
  include Mongoid::Document
  include Mongoid::Timestamps 
  field :truck_id
  field :mphone
  field :paizhao
  field :history,:type=>Array
end
