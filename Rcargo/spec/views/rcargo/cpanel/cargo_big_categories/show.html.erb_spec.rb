require 'spec_helper'

describe "cpanel_cargo_big_categories/show" do
  before(:each) do
    @cargo_big_category = assign(:cargo_big_category, stub_model(Cpanel::CargoBigCategory,
      :code => "Code",
      :name => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Code/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end
