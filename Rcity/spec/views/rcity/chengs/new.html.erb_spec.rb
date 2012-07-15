require 'spec_helper'

describe "rcity/chengs/new" do
  before(:each) do
    assign(:cheng, stub_model(Rcity::Cheng).as_new_record)
  end

  it "renders new cheng form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => chengs_path, :method => "post" do
    end
  end
end
