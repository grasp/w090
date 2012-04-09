require 'spec_helper'

describe Rforum::Node do

  describe 'Validates' do
    it 'should fail saving without specifing a section' do
      node = Rforum::Node.new
      node.name = "Cersei"
      node.summary = "the Queue"
      node.save == false
    end
  end

  describe "CacheVersion update" do
    it "should update on save" do
      old = Rforum::CacheVersion.section_node_updated_at
      sleep(1)
      node = FactoryGirl.create(:node)
      Rforum::CacheVersion.section_node_updated_at.should_not == old      
    end

    it "should update on destroy" do
      node = FactoryGirl.create(:node)
      old = Rforum::CacheVersion.section_node_updated_at
      sleep(1)
      node.destroy
      Rforum::CacheVersion.section_node_updated_at.should_not == old      
    end
  end

end
