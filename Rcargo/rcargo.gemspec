$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rcargo/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rcargo"
  s.version     = Rcargo::VERSION
  s.authors     = ["hunter"]
  s.email       = ["hunter.wxhu@gmail.com"]
  s.homepage    = "http://github.com"
  s.summary     = " Summary of Rcargo."
  s.description = " Description of Rcargo."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.3"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
