require 'spec_helper'

describe Rforum::Page do
  it 'slug has check format' do
    page = Rforum::Page.create(:title => "Foo bar", :slug => "foo.bar")
    page.should have(1).error_on(:slug)

    page = Rforum::Page.create(:title => "Foo bar", :slug => "foo-bar")
    page.should_not have(1).error_on(:slug)

    page = Rforum::Page.create(:title => "Foo bar", :slug => "foo_bar")
    page.should_not have(1).error_on(:slug)

    page = Rforum::Page.create(:title => "Foo bar", :slug => "foo-bar-1")
    page.should_not have(1).error_on(:slug)
  end
end
