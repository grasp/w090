
require "mongoid"
require "bson_ext/cbson"

require 'mongo-rails-instrumentation'
require 'mongoid_auto_increment_id'
require 'mongoid_rails_migrations'

require 'will_paginate'
require 'will_paginate_mongoid'
require 'bootstrap-will_paginate'

# permission
require "cancan"

# Redis 命名空间
require  'redis-namespace'

# 将一些数据存放入 Redis
#require  "redis-objects"
require  "redis/objects"

# Markdown 格式
require "redcarpet"
require 'hpricot'
require "pygments.rb"

# YAML 配置信息
require "settingslogic"


require "cell"

# 队列
require "resque/server"
require "resque_mailer"


# AWS Simple Email Server
require  "aws/ses"#, "~> 0.4.3"
#gem 'mail_view', :git => 'git://github.com/37signals/mail_view.git'
require  'mail_view'#, :path => "~/vob/github/mail_view"
# 用于组合小图片
#require  "sprite-factory"#, "1.4.1"
require 'sprite_factory'
# 分享功能
require  "social-share-button"#, "~> 0.0.3"

# 表单 last commit: 2011-12-03
#gem 'simple_form', :git => "git://github.com/plataformatec/simple_form.git"
require  'simple_form'#, :path => "~/vob/github/simple_form"


# 全文搜索
require  'sunspot_rails'#,  "~> 1.3.0"
require  'sunspot_solr'

require  'daemon_spawn'

# 禁用 assets 日志
#gem 'quiet_assets', :git => 'git://github.com/AgilionApps/quiet_assets.git'
require 'quiet_assets'#, :path => '~/vob/github/quiet_assets'

# Github API
require 'ruby-github'

# API
#gem 'grape', :git => 'http://github.com/intridea/grape.git', :branch => 'frontier'
require 'grape'#,  :path => '~/vob/github/grape'
require  'kgio'


module Rforum
  class Engine < ::Rails::Engine   
   
   config.to_prepare do
      Rforum::Engine.customize_user
    end

    initializer 'Rforum::Application.helper' do |app|
    ActionView::Base.send :include, Rforum::NotesHelper,Rforum::TopicsHelper,Rforum::LikesHelper,Rforum::NodesHelper#why not recognize helper???hunter
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


    def self.customize_user      
      Ruser::User.class_eval do
        has_many :topics, :dependent => :destroy,:class_name=>"Rforum::Topic"
        has_many :notes,:class_name=>"Rforum::Note"
        has_many :replies, :dependent => :destroy,:class_name=>"Rforum::Reply"
        has_many :posts,:class_name=>"Rforum::Post"
        has_many :photos,:class_name=>"Rforum::Photo"
        has_many :likes,:class_name=>"Rforum::Like"        
        has_and_belongs_to_many :following_nodes, :class_name => 'Rforum::Node', :inverse_of => :followers #this will not work without forum
      end
    end
  end

end
