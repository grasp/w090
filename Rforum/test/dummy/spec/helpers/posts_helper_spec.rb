require "spec_helper"

describe Rforum::PostsHelper do
  before(:each) do
    @post = FactoryGirl.create :post
  end

  describe "post_title_tag" do
    it "should return link" do
      helper.post_title_tag(@post).should == %{<a href="/posts/#{@post.id}" title="#{@post.title}">#{@post.title}</a>}
    end
  end
end
