require 'spec_helper'

describe Rforum::ApplicationHelper do
  it 'formats the flash messages' do
    helper.notice_message.should == ''
    helper.notice_message.html_safe?.should == true

    controller.flash[:notice] = 'hello'
    helper.notice_message.should == '<div class="alert-message success"><a href="#" class="close">x</a>hello</div>'
    controller.flash[:notice] = nil

    controller.flash[:warning] = 'hello'
    helper.notice_message.should == '<div class="alert-message warning"><a href="#" class="close">x</a>hello</div>'
    controller.flash[:warning] = nil

    controller.flash[:alert] = 'hello'
    helper.notice_message.should == '<div class="alert-message alert"><a href="#" class="close">x</a>hello</div>'
    controller.flash[:alert] = nil

    controller.flash[:error] = 'hello'
    helper.notice_message.should == '<div class="alert-message error"><a href="#" class="close">x</a>hello</div>'
    controller.flash[:error] = nil
  end

  describe "admin?" do
    let(:user) { FactoryGirl.create :user }
    let(:admin) { FactoryGirl.create :admin }

    it "knows you are not an admin" do
      helper.admin?(user).should be_false
    end

    it "knows who is the boss" do
      helper.admin?(admin).should be_true
    end

    it "use current_user if user not given" do
      helper.stub(:current_user).and_return(admin)
      helper.admin?(nil).should be_true
    end

    it "use current_user if user not given a user" do
      helper.stub(:current_user).and_return(user)
      helper.admin?(nil).should be_false
    end

    it "know you are not an admin if current_user not present and user param is not given" do
      helper.stub(:current_user).and_return(nil)
      helper.admin?(nil).should be_false
    end
  end

  describe "wiki_editor?" do
    let(:non_editor) { FactoryGirl.create :non_wiki_editor }
    let(:editor) { FactoryGirl.create :wiki_editor }

    it "knows non editor is not wiki editor" do
      helper.wiki_editor?(non_editor).should be_false
    end

    it "knows wiki editor is wiki editor" do
      helper.wiki_editor?(editor).should be_true
    end

    it "use current_user if user not given" do
      helper.stub(:current_user).and_return(editor)
      helper.wiki_editor?(nil).should be_true
    end

    it "know you are not an wiki editor if current_user not present and user param is not given" do
      helper.stub(:current_user).and_return(nil)
      helper.wiki_editor?(nil).should be_false
    end
  end

  describe "owner?" do
    require "ostruct"
    let(:user) { FactoryGirl.create :user }
    let(:user2) { FactoryGirl.create :user }
    let(:item) { OpenStruct.new :user_id => user.id }

    it "knows who is owner" do
      helper.owner?(nil).should be_false

      helper.stub(:current_user).and_return(nil)
      helper.owner?(item).should be_false

      helper.stub(:current_user).and_return(user)
      helper.owner?(item).should be_true

      helper.stub(:current_user).and_return(user2)
      helper.owner?(item).should be_false
    end
  end
end
