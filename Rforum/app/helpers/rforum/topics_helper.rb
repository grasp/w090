# coding: utf-8
require 'digest/md5'
module Rforum::TopicsHelper
  def format_topic_body(text)
    MarkdownTopicConverter.format(text)
  end

  def topic_use_readed_text(state)
    case state
    when true
      t("topics.have_no_new_reply")
    else
      t("topics.has_new_replies")
    end
  end

  def render_topic_title(topic)
    return t("topics.topic_was_deleted") if topic.blank?
    link_to(topic.title, topic_path(topic), :title => topic.title)
  end

  def render_topic_last_reply_time(topic)
    l((topic.replied_at || topic.created_at), :format => :short)
  end

  def render_topic_count(topic)
    topic.replies_count
  end

  def render_topic_created_at(topic)
    timeago(topic.created_at)
  end

  def render_topic_last_be_replied_time(topic)
    timeago(topic.replied_at)
  end

  def render_topic_node_select_tag(topic)
    return if topic.blank?
    grouped_collection_select :topic, :node_id, Rforum::Section.all, 
                    :sorted_nodes, :name, :id, :name, :value => topic.node_id,
                    :include_blank => true, :prompt => "选择节点"
  end
  #move from notes helper as partial template did no recognize notes_helper , strange!!
    def render_node_name(name, id)
    link_to(name, node_topics_path(id))
 end
end
