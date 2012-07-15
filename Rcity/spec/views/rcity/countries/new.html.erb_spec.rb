require 'spec_helper'

describe "rcity/countries/new" do
  before(:each) do
    assign(:country, stub_model(Rcity::Country,:code=>"086",:name=>"china").as_new_record)
  end

  it "renders new country form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => countries_path, :method => "post" do
    end
  end
end
