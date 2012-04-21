module Rcity
  class Engine < ::Rails::Engine
    isolate_namespace Rcity
    config.generators do |g|      
      g.orm  :mongoid
      g.test_framework :rspec
      g.integration_tool :rspec
    end
    

    config.time_zone = 'Beijing'
    config.i18n.default_locale = "zh-CN"
    #config.i18n.load_path += Dir[config.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.load_path += Dir[config.root.join('locales', '*.{rb,yml}').to_s]
    config.encoding = "utf-8"
  end
end
