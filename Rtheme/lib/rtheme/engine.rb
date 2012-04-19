require 'rubygems'
require 'bootstrap-rails'
require 'will_paginate'
require  'will_paginate_mongoid'
require  'bootstrap-will_paginate'
require "breadcrumb"  #as Rtheme is common , so put breadcrumb into rtheme lib ,so all app can use
require 'helper' #from bootstrap-rails of xdite of ruby-china
require 'application_controller_common' #from bootstrap-rails of xdite of ruby-china


module Rtheme
  class Engine < ::Rails::Engine
    isolate_namespace Rtheme

        #load all helper, otherwise will cover by parent app with same name
    initializer 'Rtheme::ApplicationController' do |app|
      ActionView::Base.send :include, Bootstrap::Breadcrumb::Helpers
      ActionView::Base.send :include, Bootstrap::Helper
      #  ActionController::Base .send :include,  ApplicationHelper,UsersHelper
    app.config.assets.paths += ["#{config.root}/vendor/assets/stylesheets/bootstrap202"]
    app.config.assets.paths += ["#{config.root}/vendor/assets/javascripts/bootstrap202"]
    app.config.assets.paths += ["#{config.root}/vendor/assets/images/bootstrap202"]
    end
    
  end
end
