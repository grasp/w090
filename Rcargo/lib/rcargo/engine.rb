module Rcargo
  class Engine < ::Rails::Engine
    isolate_namespace Rcargo
    config.generators do |g|      
      g.orm  :mongoid
      g.test_framework :rspec
      g.integration_tool :rspec
    end
  end
end
