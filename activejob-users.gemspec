$:.push File.expand_path("../lib", __FILE__)
require "active_job/users/version"

Gem::Specification.new do |s|
  s.name        = "activejob-users"
  s.version     = ActiveJob::Users::VERSION
  s.summary     = "Pass a user through to your active_jobs for context"
  s.description = "Pass a user through to your active_jobs for context"
  s.authors     = ["Mark Rebec"]
  s.email       = ["mark@markrebec.com"]
  s.homepage    = "http://github.com/markrebec/activejob-users"

  s.files       = Dir["lib/**/*"]
  s.test_files  = Dir["spec/**/*"]

  s.add_dependency "rails"

  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
end
