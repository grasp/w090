require 'rubygems'
require 'pathname'
#require 'bootstrap-rails'
require 'will_paginate'
require  'will_paginate_mongoid'
require  'bootstrap-will_paginate'
#require " ../breadcrumb.rb"  #as Rtheme is common , so put breadcrumb into rtheme lib ,so all app can use
require File.join(Pathname.new(File.dirname(__FILE__)).parent,"breadcrumb.rb")
require File.join(Pathname.new(File.dirname(__FILE__)).parent,"helper.rb")
require File.join(Pathname.new(File.dirname(__FILE__)).parent,"application_controller_common.rb")
require File.join(Pathname.new(File.dirname(__FILE__)).parent,"application_helper_common.rb")
#require 'helper' #from bootstrap-rails of xdite of ruby-china
#require 'application_controller_common' #from bootstrap-rails of xdite of ruby-china
#require 'application_helper_common' #from bootstrap-rails of xdite of ruby-china

module Rtheme
  class Engine < ::Rails::Engine
   

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

   #why not work? each time did not load change
    config.autoload_paths << File.expand_path("#{config.root}/lib", __FILE__) #this could be bug of rails engine?   
     isolate_namespace Rtheme
  end
end
