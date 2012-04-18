require 'rubygems'
require 'bootstrap-rails'
require 'will_paginate'
require  'will_paginate_mongoid'
require  'bootstrap-will_paginate'


module Rtheme
  class Engine < ::Rails::Engine
    isolate_namespace Rtheme
  end
end
