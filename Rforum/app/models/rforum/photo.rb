# coding: utf-8
class Rforum::Photo
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  field :image

  belongs_to :user ,:class_name=>"Ruser::User"

  attr_accessible :image

  # 封面图
  mount_uploader :image, PhotoUploader

end
