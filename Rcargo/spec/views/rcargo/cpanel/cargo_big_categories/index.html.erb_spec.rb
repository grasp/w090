require 'spec_helper'

describe "cpanel_cargo_big_categories/index" do
  before(:each) do
    assign(:cpanel_cargo_big_categories, [
      stub_model(Cpanel::CargoBigCategory,
        :code => "Code",
        :name => ""
      ),
      stub_model(Cpanel::CargoBigCategory,
        :code => "Code",
        :name => ""
      )
    ])
  end

  it "renders a list of cpanel_cargo_big_categories" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Code".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
