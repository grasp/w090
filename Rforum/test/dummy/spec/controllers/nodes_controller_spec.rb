require "spec_helper"

describe Rforum::NodesController do
  it "should have an index action" do
    get :index
    response.should be_success
  end
end