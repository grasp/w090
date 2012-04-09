require "spec_helper"

describe Rforum::SiteConfig do
  let!(:config) { FactoryGirl.create :site_config }

  describe "#update_cache" do
    it "should update cache" do
      Rails.cache.should_receive(:write).with("site_config:#{config.key}", config.value)
      config.update_cache
    end

    it "should update cache after config is saved" do
      Rails.cache.should_receive(:write).with("site_config:#{config.key}", config.value)
      config.save
    end
  end

  describe "find_by_key" do
    it "should be able to find_by_key" do
      Rforum::SiteConfig.find_by_key(config.key).value.should == config.value
    end
  end

  describe "save_default" do
    it "should create config if not exist" do
      attributes = FactoryGirl.attributes_for :site_config
      Rforum::SiteConfig.should_receive(:create).with(:key => attributes[:key], :value => attributes[:value])
      Rforum::SiteConfig.save_default(attributes[:key], attributes[:value])
    end

    it "should not change value if key presents" do
      Rforum::SiteConfig.should_not_receive(:create)
      Rforum::SiteConfig.save_default(config.key, "new value")
      Rforum::SiteConfig.find_by_key(config.key).value.should_not == "new value"
      Rforum::SiteConfig.find_by_key(config.key).value.should == config.value
    end
  end

  describe "method_missing" do
    describe "setter" do
      it "should create new config if key not present" do
        Rforum::SiteConfig.should_receive(:create).with(:key => "not_exists_yet", :value => "some value")
        Rforum::SiteConfig.not_exists_yet = "some value"
      end

      it "should update config if key present" do
        Rforum::SiteConfig.send "#{config.key}=", "new value"
        Rforum::SiteConfig.find_by_key(config.key).value.should == "new value"
      end
    end

    describe "getter" do
      it "should read cache if presents" do
        Rforum::SiteConfig.should_not_receive(:where)
        Rails.cache.write("site_config:#{config.key}", config.value)
        Rforum::SiteConfig.send(config.key).should == config.value
      end

      it "should fetch value and update cache" do
        Rails.cache.clear
        Rforum::SiteConfig.send(config.key).should == config.value
        Rails.cache.read("site_config:#{config.key}").should == config.value
      end

      it "should return nil if key not present" do
        Rforum::SiteConfig.not_exists_yet.should be_nil
      end
    end
  end
end