require "spec_helper"
if false
describe Rcity::ChengsController do
  describe "routing" do

    it "routes to #index" do
      get("/chengs").should route_to("chengs#index")

    end

    it "routes to #new" do
      get("/chengs/new").should route_to("chengs#new")

    end

    it "routes to #show" do
      get("/chengs/1").should route_to("chengs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/chengs/1/edit").should route_to("chengs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/chengs").should route_to("chengs#create")
    end

    it "routes to #update" do
      put("/chengs/1").should route_to("chengs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/chengs/1").should route_to("chengs#destroy", :id => "1")
    end

  end
end
end
