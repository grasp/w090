require 'spec_helper'

if false

describe "rcity/chengs/index" do
  before(:each) do
    assign(:chengs, [
      stub_model(Rcity::Cheng),
      stub_model(Rcity::Cheng)
    ])
  end

  it "renders a list of chengs" do
    render
  end
end
end
