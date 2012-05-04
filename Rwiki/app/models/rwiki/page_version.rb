class Rforum::PageVersion
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user ,:class_name=>"Ruser::User"
  belongs_to :page,:class_name=>"Rforum::Page"
  field :version, :type => Integer
  field :desc
  field :body
  field :slug
  field :title

  index :page_id
  index [[:page_id, Mongo::ASCENDING], [:version,Mongo::ASCENDING]]
end
