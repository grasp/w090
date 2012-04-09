require 'spec_helper'

describe Rforum::RepliesController do
  describe "#create" do#####$#
    it "should create reply and set topic read" do
      user = FactoryGirl.create :user
      topic = FactoryGirl.create :topic
      FactoryGirl.create :reply, :topic => topic,:user=> user
      user.topic_read?(topic).should be_false
      sign_in user
      post :create, :topic_id => topic.id, :reply => {:body => 'content'}, :format => :js
      topic.reload
      user.topic_read?(topic).should be_true
    end
  end
end
