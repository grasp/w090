module Rcity
  class Engine < ::Rails::Engine
    isolate_namespace Rcity
    config.generators do |g|      
      g.orm  :mongoid
      g.test_framework :rspec
      g.integration_tool :rspec
    end
    
   initializer 'Rforum::Application.helper' do |app|
    #  ActionView::Base.send :include, Rcity::Engine.routes.url_helpers  # some path in dummy env did not recoginize,but have issue
    end
  end
end
