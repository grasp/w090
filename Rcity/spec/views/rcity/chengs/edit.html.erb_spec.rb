require 'spec_helper'

if false  ##why rspec not recoginize chengs_path
describe "rcity/chengs/edit" do
  before(:each) do
    @cheng = assign(:cheng, stub_model(Rcity::Cheng))
  end

  it "renders the edit cheng form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => rcity.chengs_path(@cheng), :method => "post" do
    end
  end
end
end
