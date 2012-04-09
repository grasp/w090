require "spec_helper"

describe Rforum::NodesHelper do
  it "should render_node_summary" do
    @node = FactoryGirl.create :node
    helper.render_node_summary(@node).should == %{<p class="summary">#{@node.summary}</p>}
  end
end
