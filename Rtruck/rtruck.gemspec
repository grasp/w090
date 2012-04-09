$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rtruck/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rtruck"
  s.version     = Rtruck::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Rtruck."
  s.description = "TODO: Description of Rtruck."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.3"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
