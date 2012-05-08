module Rtruck
  class Engine < ::Rails::Engine
    isolate_namespace Rtruck
    config.generators do |g|      
      g.orm  :mongoid
      g.test_framework :rspec
      g.integration_tool :rspec
    end

    config.to_prepare do
       Rtruck::Engine.customize_user
       Rtruck::ApplicationController.send :include, Bootstrap::Breadcrumb
    end

    config.time_zone = 'Beijing'
    config.i18n.default_locale = "zh-CN"
    #config.i18n.load_path += Dir[config.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.load_path += Dir[config.root.join('locales', '*.{rb,yml}').to_s]
    config.encoding = "utf-8"

  def self.customize_user      
      Ruser::User.class_eval do
         has_many :stock_trucks, :dependent => :destroy,:class_name=>"Rtruck::StockTruck"
         has_many :trucks, :dependent => :destroy,:class_name=>"Rtruck::Truck"
      end
    end

  end
end
