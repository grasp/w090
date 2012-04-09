# To change this template, choose Tools | Templates
# and open the template in the editor.

module Rforum::CellHelper
  include Rforum::NodesHelper
  # 首页节点目录
#  cache :index_sections do |cell|
#    "index_sections:#{CacheVersion.section_node_updated_at}"
#  end
  def index_sections
    @sections = Rforum::Section.all
    render
  end

  # 边栏的统计信息
 # cache :sidebar_statistics, :expires_in => 30.minutes
  def sidebar_statistics
    render
  end

  # 热门节点
  #cache :sidebar_hot_nodes, :expires_in => 30.minutes
  def sidebar_hot_nodes
    @hot_nodes = Rforum::Node.hots.limit(30)
    render
  end

  # 置顶话题
  #ache :sidebar_suggest_topics do |cell|
  #  "sidebar_suggest_topics:#{CacheVersion.topic_last_suggested_at}"
 # end
  def sidebar_suggest_topics
    @suggest_topics = Rforum::Topic.suggest.limit(5)
    render
  end

  def sidebar_for_new_topic_node(args = {})
    @node = args[:node]
    @action = args[:action]
    render
  end

  # 相关类似话题, 取相关词出现最少3次，相关度最高的3篇
 # cache :sidebar_for_more_like_this, :expires_in => 1.day do |cell, args|
 #   args[:topic].id
 # end
  def sidebar_for_more_like_this(args = {})
    @topics = args[:topic].more_like_this do
      minimum_term_frequency 5
      paginate :page => 1, :per_page => 10
    end.results
    render
  end

  def reply_help_block(opts = {})
    @full = opts[:full] || false
    render
  end

 # cache :index_locations, :expires_in => 1.days
  def index_locations
    @hot_locations = Ruser::Location.hot.limit(12)
    render
  end
end
