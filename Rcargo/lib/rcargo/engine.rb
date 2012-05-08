module Rcargo
  class Engine < ::Rails::Engine

    isolate_namespace Rcargo

    config.generators do |g|      
      g.orm  :mongoid
      g.test_framework :rspec
      g.integration_tool :rspec
    end

    config.to_prepare do
      Rcargo::Engine.customize_user
       Rcargo::ApplicationController.send :include, Bootstrap::Breadcrumb
    end

    config.time_zone = 'Beijing'
    config.i18n.default_locale = "zh-CN"
    #config.i18n.load_path += Dir[config.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.load_path += Dir[config.root.join('locales', '*.{rb,yml}').to_s]
    config.encoding = "utf-8"

  def self.customize_user      
      Ruser::User.class_eval do
         has_many :stock_cargos, :dependent => :destroy,:class_name=>"Rcargo::StockCargo"
         has_many :cargos, :dependent => :destroy,:class_name=>"Rcargo::Cargo"
      end
    end
  end

end
