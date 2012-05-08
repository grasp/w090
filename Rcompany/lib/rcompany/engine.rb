module Rcompany
  class Engine < ::Rails::Engine
    isolate_namespace Rcompany


    config.generators do |g|      
      g.orm  :mongoid
      g.test_framework :rspec
      g.integration_tool :rspec
    end

    config.to_prepare do
       Rcompany::Engine.customize_user
       Rcompany::ApplicationController.send :include, Bootstrap::Breadcrumb
    end

    config.time_zone = 'Beijing'
    config.i18n.default_locale = "zh-CN"
    #config.i18n.load_path += Dir[config.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.load_path += Dir[config.root.join('locales', '*.{rb,yml}').to_s]
    config.encoding = "utf-8"

  def self.customize_user      
      Ruser::User.class_eval do
         has_one :company, :dependent => :destroy,:class_name=>"Rcompany::Company"
      end
  end
end
end
