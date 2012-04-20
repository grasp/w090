require "spec_helper"

describe Cpanel::CargoBigCategoriesController do
  describe "routing" do

    it "routes to #index" do
      get("/cpanel_cargo_big_categories").should route_to("cpanel_cargo_big_categories#index")
    end

    it "routes to #new" do
      get("/cpanel_cargo_big_categories/new").should route_to("cpanel_cargo_big_categories#new")
    end

    it "routes to #show" do
      get("/cpanel_cargo_big_categories/1").should route_to("cpanel_cargo_big_categories#show", :id => "1")
    end

    it "routes to #edit" do
      get("/cpanel_cargo_big_categories/1/edit").should route_to("cpanel_cargo_big_categories#edit", :id => "1")
    end

    it "routes to #create" do
      post("/cpanel_cargo_big_categories").should route_to("cpanel_cargo_big_categories#create")
    end

    it "routes to #update" do
      put("/cpanel_cargo_big_categories/1").should route_to("cpanel_cargo_big_categories#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/cpanel_cargo_big_categories/1").should route_to("cpanel_cargo_big_categories#destroy", :id => "1")
    end

  end
end
