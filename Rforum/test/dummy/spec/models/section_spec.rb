require 'spec_helper'

describe Rforum::Section do

  describe "CacheVersion update" do
    it "should update on save" do
      old = Rforum::CacheVersion.section_node_updated_at
      sleep(1)
      section = FactoryGirl.create(:section)
      Rforum::CacheVersion.section_node_updated_at.should_not == old      
    end

    it "should update on destroy" do
      section = FactoryGirl.create(:section)
      old = Rforum::CacheVersion.section_node_updated_at
      sleep(1)
      section.destroy
      Rforum::CacheVersion.section_node_updated_at.should_not == old      
    end
  end

end
