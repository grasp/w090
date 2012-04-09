$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rtheme/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rtheme"
  s.version     = Rtheme::VERSION
  s.authors     = ["hunter"]
  s.email       = ["hunter.wxhu@gmail.com"]
  s.homepage    = "http://grasp@github.com"
  s.summary     = "Summary of Rtheme."
  s.description = "Description of Rtheme."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.2"
  # s.add_dependency "jquery-rails"

 # s.add_development_dependency "sqlite3"
end
