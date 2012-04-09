# coding: utf-8
class Rforum::Cpanel::HomeController < Rforum::Cpanel::ApplicationController
  def index
    @recent_topics = Rforum::Topic.recent.limit(5)
  end
end
