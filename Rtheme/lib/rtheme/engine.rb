require 'rubygems'
#require 'bootstrap-rails'
require 'will_paginate'
require  'will_paginate_mongoid'
require  'bootstrap-will_paginate'
require "breadcrumb"  #as Rtheme is common , so put breadcrumb into rtheme lib ,so all app can use
require 'helper' #from bootstrap-rails of xdite of ruby-china
require 'application_controller_common' #from bootstrap-rails of xdite of ruby-china
require 'application_helper_common' #from bootstrap-rails of xdite of ruby-china

module Rtheme
  class Engine < ::Rails::Engine
    isolate_namespace Rtheme

        #load all helper, otherwise will cover by parent app with same name
    initializer 'Rtheme::ApplicationController' do |app|
      ActionView::Base.send :include, Bootstrap::Breadcrumb::Helpers
      ActionView::Base.send :include, Bootstrap::Breadcrumb::InstanceMethods
      ActionView::Base.send :include, Bootstrap::Helper
      ActionView::Base.send :include, ApplicationHelperCommon
        ActionController::Base .send :include,  Bootstrap::Breadcrumb::Helpers
        ActionController::Base .send :include,  Bootstrap::Helper
        ActionController::Base .send :include,  Bootstrap::Breadcrumb::InstanceMethods
         ActionController::Base .send :include,  ApplicationHelperCommon
         ActionController::Base .send :before_filter,  :set_breadcrumbs
    
    app.config.assets.paths += ["#{config.root}/vendor/assets/stylesheets/bootstrap202"]
    app.config.assets.paths += ["#{config.root}/vendor/assets/javascripts/bootstrap202"]
    app.config.assets.paths += ["#{config.root}/vendor/assets/javascripts/jquery172"]
    app.config.assets.paths += ["#{config.root}/vendor/assets/images/bootstrap202"]
    end
    
  end
end
