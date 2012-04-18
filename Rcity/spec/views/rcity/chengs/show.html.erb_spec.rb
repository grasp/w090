require 'spec_helper'

describe "rcity/chengs/show" do
  before(:each) do
    @cheng = assign(:cheng, stub_model(Rcity::Cheng))
  end

  it "renders attributes in <p>" do
    render
  end
end
