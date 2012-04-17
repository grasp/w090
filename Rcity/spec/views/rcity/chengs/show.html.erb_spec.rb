require 'spec_helper'

describe "chengs/show" do
  before(:each) do
    @cheng = assign(:cheng, stub_model(Cheng))
  end

  it "renders attributes in <p>" do
    render
  end
end
