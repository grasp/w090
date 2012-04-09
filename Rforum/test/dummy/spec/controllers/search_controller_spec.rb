require "spec_helper"

describe Rforum::SearchController, :solr => true do
  context "GET index" do
    it "should search topics" do
      topic = FactoryGirl.create :topic
      Sunspot.commit
      get :index, :q => topic.title
      assigns[:search].should_not be_nil
      assigns[:search].results.count.should == 1
      assigns[:search].results.first.title.should == topic.title
    end
  end

  context "GET wiki" do
    it "should search wiki pages" do
      page = FactoryGirl.create :page
      Sunspot.commit
      get :wiki, :q => page.title
      assigns[:search].should_not be_nil
      assigns[:search].results.count.should == 1
      assigns[:search].results.first.title.should == page.title
    end
  end
end