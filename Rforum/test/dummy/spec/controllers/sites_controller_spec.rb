require "spec_helper"

describe Rforum::SitesController do
  let(:user) { FactoryGirl.create :user }
  describe ":index" do
    it "should have an index action" do
      get :index##
      response.should be_success
    end
  end

  describe ":new" do
    it "should not allow anonymous access" do
      get :new
      response.should_not be_success
    end

    it "should allow access from authenticated user" do
      sign_in user
      get :new
      response.should be_success
    end
  end

  describe ":create" do
    let(:site_node) { FactoryGirl.create :site_node }
    it "should not allow anonymous access" do
      post :create
      response.should_not be_success
    end

    describe "authenticated" do
      before(:each) do
        sign_in user
      end

      it "should create new site if all is well" do
        params = FactoryGirl.attributes_for(:site, :site_node => site_node.id)
        post :create, :site => params
        response.should redirect_to(sites_path(:use_route=>"rforum"))
      end

      it "should not create new site if url is blank" do
        params = FactoryGirl.attributes_for(:site)
        params[:url] = ""
        post :create, :site => params
        response.should render_template(:new)
      end
    end
  end
end