require 'spec_helper'

describe "chengs/edit" do
  before(:each) do
    @cheng = assign(:cheng, stub_model(Cheng))
  end

  it "renders the edit cheng form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => chengs_path(@cheng), :method => "post" do
    end
  end
end
