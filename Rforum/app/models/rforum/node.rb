# coding: utf-8
class Rforum::Node
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel
  cache

  field :name
  field :summary
  field :sort, :type => Integer, :default => 0
  field :topics_count, :type => Integer, :default => 0

  has_many :topics,:class_name=>"Rforum::Topic"
  belongs_to :section,:class_name=>"Rforum::Section"

  index :section_id

  validates_presence_of :name, :summary, :section
  validates_uniqueness_of :name

  has_and_belongs_to_many :followers, :class_name => 'Ruser::User', :inverse_of => :following_nodes

  scope :hots, desc(:topics_count)
  scope :sorted, desc(:sort)

  after_save :update_cache_version
  after_destroy :update_cache_version

  def update_cache_version
    # 记录节点变更时间，用于清除缓存
    Rforum::CacheVersion.section_node_updated_at = Time.now
  end

  # 热门节电给 select 用的
  def self.node_collection
    Rails.cache.fetch("node:node_collection:#{Rforum::CacheVersion.section_node_updated_at}") do
      Node.all.collect { |n| [n.name,n.id] }
    end
  end
end
