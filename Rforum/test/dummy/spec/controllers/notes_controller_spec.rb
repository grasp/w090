require "spec_helper"

describe Rforum::NotesController do
  describe "unauthenticated" do
    it "should not allow anonymous access" do
      get :index
      response.should_not be_success
    end
  end

  describe "authenticated" do
    let(:user) { FactoryGirl.create:user }
    let(:note) { FactoryGirl.create:note, :user => user }

    before(:each) { sign_in user }

    describe ":index" do
      it "should have an index action" do
        get :index
        response.should be_success
      end
    end

    describe ":new" do
      it "should have a new action" do
        get :new
        response.should be_success
      end
    end

    describe ":edit" do
      it "should have an edit action" do
        get :edit, :id => note.id
        assigns[:note].should_not be_blank
        response.should be_success
      end
    end

    describe ":show" do
      it "should have a show action" do
        get :show, :id => note.id
        response.should be_success
      end
    end
  end
end