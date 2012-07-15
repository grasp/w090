require 'spec_helper'

describe "cpanel_cargo_big_categories/new" do
  before(:each) do
    assign(:cargo_big_category, stub_model(Cpanel::CargoBigCategory,
      :code => "MyString",
      :name => ""
    ).as_new_record)
  end

  it "renders new cargo_big_category form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => cpanel_cargo_big_categories_path, :method => "post" do
      assert_select "input#cargo_big_category_code", :name => "cargo_big_category[code]"
      assert_select "input#cargo_big_category_name", :name => "cargo_big_category[name]"
    end
  end
end
