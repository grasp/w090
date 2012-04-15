require 'spec_helper'

describe "rcity/countries/show" do
  before(:each) do
    @country = assign(:country, stub_model(Rcity::Country))
  end

  it "renders attributes in <p>" do
    render
  end
end
