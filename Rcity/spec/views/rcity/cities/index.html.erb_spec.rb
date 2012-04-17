require 'spec_helper'

describe "cities/index" do
  before(:each) do
    assign(:cities, [
      stub_model(City),
      stub_model(City)
    ])
  end

  it "renders a list of cities" do
    render
  end
end
