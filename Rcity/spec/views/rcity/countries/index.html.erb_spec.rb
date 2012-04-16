require 'spec_helper'

describe "rcity/countries/index" do
  before(:each) do
    assign(:countries, [
      stub_model(Rcity::Country,:code=>"086",:name=>"china"),
      stub_model(Rcity::Country,:code=>"087",:name=>"china2")
    ])
  end

  it "renders a list of countries" do
    render
  end
end
