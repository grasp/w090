# coding: utf-8
module Rforum::RepliesHelper
  def render_reply_at(reply)
    l( reply.created_at, :format => :short)
  end
end
