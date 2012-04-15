require 'spec_helper'

describe "rcity/countries/index" do
  before(:each) do
    assign(:countries, [
      stub_model(Rcity::Country),
      stub_model(Rcity::Country)
    ])
  end

  it "renders a list of countries" do
    render
  end
end
