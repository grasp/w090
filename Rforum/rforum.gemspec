$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rforum/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rforum"
  s.version     = Rforum::VERSION
  s.authors     = ["hunter"]
  s.email       = ["hunter.wxhu@gmail.com"]
  s.homepage    = "http://grasp@github.com"
  s.summary     = "Summary of Rforum."
  s.description = "Description of Rforum."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.3"
  # s.add_dependency "jquery-rails"

  #s.add_development_dependency "sqlite3"

   s.add_dependency "execjs"
   s.add_dependency "rails-i18n","0.1.8"
  s.add_dependency "jquery-rails", "1.0.16"
  s.add_dependency "rails_autolink", ">= 1.0.4"
  s.add_dependency "jquery-atwho-rails", "0.1.5"

#group :assets do
 # gem 'sass-rails', "  ~> 3.2.3"
#  gem 'coffee-rails', "~> 3.2.1"
#  gem 'uglifier', '>= 1.0.3'
#end

#this is for init_breadcrume....
#gem 'bootstrap-rails', :require => 'bootstrap-rails', :git => 'git://github.com/xdite/bootstrap-rails.git'
 # s.add_dependency  'bootstrap-rails', :require => 'bootstrap-rails', :path => '~/vob/github/bootstrap-rails'
  #s.add_dependency  'bootstrap-rails', :path => '~/vob/github/bootstrap-rails'
# 上传组件
  s.add_dependency  'carrierwave', '0.5.7'
  s.add_dependency  'carrierwave-mongoid', '0.1.2'#, :require => 'carrierwave/mongoid'
  s.add_dependency  'carrierwave-upyun', '0.1.3'
  s.add_dependency  'mini_magick','3.3'

# Mongoid 辅助插件
  s.add_dependency  "mongoid", "~>2.4.8"
  s.add_dependency  "bson_ext", "~>1.5.2"
  s.add_dependency  'mongo-rails-instrumentation','0.2.4'
  s.add_dependency  'mongoid_auto_increment_id', "0.4.0"
  s.add_dependency  'mongoid_rails_migrations', '~> 0.0.14'



# 分页
  s.add_dependency  'will_paginate', '3.0.2'
  s.add_dependency  'will_paginate_mongoid', '~> 1.0.2'
  s.add_dependency  'bootstrap-will_paginate', '~>0.0.7'


# permission
  s.add_dependency  "cancan", "~> 1.6.7"

# Redis 命名空间
  s.add_dependency  'redis-namespace','~> 1.0.2'

# 将一些数据存放入 Redis
  s.add_dependency  "redis-objects", "0.5.2"

# Markdown 格式
  s.add_dependency  "redcarpet", "~> 2.0.0"
  s.add_dependency  'hpricot', '~> 0.8.5'
  s.add_dependency  "pygments.rb", '0.2.8'

# YAML 配置信息
  s.add_dependency  "settingslogic", "~> 2.0.6"



# 队列
  s.add_dependency  "resque", "~> 1.20.0"#, :require => "resque/server"
  s.add_dependency  "resque_mailer", '2.0.2'

# AWS Simple Email Server
  s.add_dependency  "aws-ses", "~> 0.4.3"
#gem 'mail_view', :git => 'git://github.com/37signals/mail_view.git'
  #s.add_dependency  'mail_view', :path => "~/vob/github/mail_view"
# 用于组合小图片
  s.add_dependency  "sprite-factory", "1.4.1"

# 分享功能
  s.add_dependency  "social-share-button", "~> 0.0.3"

# 表单 last commit: 2011-12-03
#gem 'simple_form', :git => "git://github.com/plataformatec/simple_form.git"
  #s.add_dependency 'simple_form', :path => "~/vob/github/simple_form"


# 全文搜索
  s.add_dependency  'sunspot_rails',  "~> 1.3.0"
  s.add_dependency  'sunspot_solr'

  s.add_dependency  'daemon-spawn'

# 禁用 assets 日志
#gem 'quiet_assets', :git => 'git://github.com/AgilionApps/quiet_assets.git'
  #s.add_dependency  'quiet_assets', :path => '~/vob/github/quiet_assets'

# Github API
  s.add_dependency  'ruby-github'

# API
#gem 'grape', :git => 'http://github.com/intridea/grape.git', :branch => 'frontier'
 # s.add_dependency  'grape',  :path => '~/vob/github/grape'
  s.add_dependency  'kgio','2.7.4'
end
