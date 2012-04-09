module Rforum
  class Engine < ::Rails::Engine    
    initializer 'Rforum::Application.helper' do |app|
      ActionView::Base.send :include, Rforum::NotesHelper,Rforum::TopicsHelper,Rforum::LikesHelper
      #  ActionController::Base .send :include,  ApplicationHelper,UsersHelper
    end
    
    config.i18n.default_locale = "zh-CN"
    config.autoload_paths += %W(#{config.root}/uploaders)
    config.autoload_paths += %W(#{config.root}/lib)
    config.time_zone = 'Beijing'

    #   config.i18n.load_path += Dir[config.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.load_path += Dir[config.root.join('locales', '*.{rb,yml}').to_s]
 
    config.encoding = "utf-8"

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, :dir => "spec/factories"
    end
    
    isolate_namespace Rforum
  end
end
