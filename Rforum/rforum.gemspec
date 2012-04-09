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

  s.add_development_dependency "sqlite3"
end
