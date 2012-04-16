require 'spec_helper'

describe "rcity/countries/edit" do
  before(:each) do
    @country = assign(:country, stub_model(Rcity::Country,:code=>"086",:name=>"china"))
 #@country = assign(:country, let(:country){FactoryGirl(:country)})
  end

  it "renders the edit country form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => countries_path(@country), :method => "post" do
    end
  end
end
