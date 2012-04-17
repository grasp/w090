require 'spec_helper'

describe "chengs/index" do
  before(:each) do
    assign(:chengs, [
      stub_model(Cheng),
      stub_model(Cheng)
    ])
  end

  it "renders a list of chengs" do
    render
  end
end
