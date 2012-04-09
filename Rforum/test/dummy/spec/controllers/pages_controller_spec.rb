require "spec_helper"

describe Rforum::PagesController do
  let(:page) { FactoryGirl.create :page }
  let(:user) { FactoryGirl.create :user }

  describe "/rforum/index" do
    it "should have an index action" do
      get :index,:use_route=>"rforum"
      response.should be_success
    end
  end

  describe ":show" do
    it "should respond with 404 to invalid request made by unauthenticated user" do
      get :show, :id => "non_existent",:use_route=>"rforum"
      response.should_not be_success
      response.status.should == 404
    end

    it "should prompt user to create new page if page not found but user is logged in" do
      sign_in user
      get :show, :id => "non_existent_yet",:use_route=>"rforum"
      response.should_not be_success
      response.status.should == 302
      response.should redirect_to(new_page_path(:title => "non_existent_yet"))
    end

    it "should respond to valid show action" do
      get :show, :id => page.slug,:use_route=>"rforum"
      response.should be_success
    end
  end

  describe ":new" do
    it "should not allow anonymous access" do
      get :new,:use_route=>"rforum"
      response.should_not be_success
    end

    it "should allowed access from authenticated user" do
      sign_in user
      get :new,:use_route=>"rforum"
      response.should be_success
    end
  end

  describe ":edit" do
    it "should not allow anonymous access" do
      get :edit,:use_route=>"rforum"
      response.should_not be_success
    end

    it "should allowed access from authenticated user" do
      sign_in user
      get :edit, :id => page.id,:use_route=>"rforum"
      response.should be_success
    end
  end

  describe ":create" do
    it "should not allow anonymous access" do
      post :create,:use_route=>"rforum"
      response.should_not be_success
    end

    it "should create new page if all is well" do
      sign_in user
      params = FactoryGirl.attributes_for(:page)
      post :create, :page => params,:use_route=>"rforum"
      response.should redirect_to page_path(params[:slug])
    end

    it "should not create new page if title is not present" do
      sign_in user
      params = FactoryGirl.attributes_for(:page)
      params[:title] = ""
      post :create, :page => params,:use_route=>"rforum"
      response.should render_template(:new)
    end
  end

  describe ":update" do
    it "should not allow anonymous access" do
      put :update,:use_route=>"rforum"
      response.should_not be_success
    end

    it "should update page if all is well" do
      sign_in user
      params = FactoryGirl.attributes_for(:page)
      page = Rforum::Page.create!(params)
      params[:title] = "shiney new title"
      params[:change_desc] = "updated title"
      put :update, :page => params, :id => page.id,:use_route=>"rforum"
      response.should redirect_to(page_path(page.slug))
    end

    it "should not update page if change_desc is not present" do
      sign_in user
      params = FactoryGirl.attributes_for(:page)
      page = Rforum::Page.create!(params)
      params[:title] = "shiney new title"
      params[:change_desc] = nil
      put :update, :page => params, :id => page.id,:use_route=>"rforum"
      response.should render_template(:edit)
    end
  end

  describe ":recent" do
    it "should have a recent action" do
      get :recent,:use_route=>"rforum"
      response.should be_success
    end
  end
end