require 'spec_helper'

describe "Cpanel::CargoBigCategories" do
  describe "GET /rcargo_cpanel_cargo_big_categories" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get rcargo_cpanel_cargo_big_categories_path
      response.status.should be(200)
    end
  end
end
