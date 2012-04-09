require 'spec_helper'
require "cancan/matchers"

describe Ability do
  subject { ability }

  context "Admin manage all" do
    let(:admin) { FactoryGirl.create :admin }
    let(:ability){ Ability.new(admin) }
    it { should be_able_to(:manage, Rforum::Topic) }
    it { should be_able_to(:manage, Rforum::Reply) }
    it { should be_able_to(:manage, Rforum::Section) }
    it { should be_able_to(:manage, Rforum::Node) }
    it { should be_able_to(:manage, Rforum::Page) }
    it { should be_able_to(:manage, Rforum::PageVersion) }
    it { should be_able_to(:manage, Rforum::Site) }
    it { should be_able_to(:manage, Rforum::Note) }
    it { should be_able_to(:manage, Rforum::Photo) }
    it { should be_able_to(:manage, Rforum::Comment) }
  end

  context "Wiki Editor manage wiki" do
    let(:wiki_editor) { FactoryGirl.create :wiki_editor }
    let(:ability){ Ability.new(wiki_editor) }
    let(:page_locked) { FactoryGirl.create :page, :locked => true }
    it { should_not be_able_to(:destroy, Rforum::Page) }
    it { should be_able_to(:create, Rforum::Page) }
    it { should be_able_to(:update, Rforum::Page) }
    it { should_not be_able_to(:update, page_locked)}
  end

  context "Normal users" do
    let(:user) { FactoryGirl.create :user }
    let(:topic) { FactoryGirl.create :topic, :user => user }
    let(:reply) { FactoryGirl.create :reply, :user => user }
    let(:note) { FactoryGirl.create :note, :user => user }
    let(:comment) { FactoryGirl.create :comment, :user => user }
    let(:note_publish) { FactoryGirl.create :note, :publish => true }

    let(:ability){ Ability.new(user) }

    context "Topic" do
      it { should be_able_to(:read, Rforum::Topic) }
      it { should be_able_to(:create, Rforum::Topic) }
      it { should be_able_to(:update, topic) }
      it { should be_able_to(:destroy, topic) }
    end

    context "Reply" do
      it { should be_able_to(:read, Rforum::Reply) }
      it { should be_able_to(:create, Rforum::Reply) }
      it { should be_able_to(:update, reply) }
      it { should be_able_to(:destroy, reply) }
    end

    context "Section" do
      it { should be_able_to(:read, Rforum::Section) }
    end

    context "Node" do
      it { should be_able_to(:read, Rforum::Node) }
    end

    context "Page (WIKI)" do
      it { should be_able_to(:read, Rforum::Page) }
    end

    context "Site" do
      it { should be_able_to(:read, Rforum::Site) }
      it { should be_able_to(:create, Rforum::Site) }
    end

    context "Note" do
      it { should be_able_to(:create, Rforum::Note) }
      it { should be_able_to(:read, note) }
      it { should be_able_to(:update, note) }
      it { should be_able_to(:destroy, note) }
      it { should be_able_to(:read, note_publish) }
    end

    context "Photo" do
      it { should be_able_to(:create, Rforum::Photo) }
      it { should be_able_to(:read, Rforum::Photo) }
    end

    context "Comment" do
      it { should be_able_to(:create, Rforum::Comment) }
      it { should be_able_to(:read, Rforum::Comment) }
      it { should be_able_to(:update, comment) }
      it { should be_able_to(:destroy, comment) }
    end
  end
end
