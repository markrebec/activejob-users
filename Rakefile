require 'rspec/core/rake_task'

task :environment do
  # noop
end

desc 'Run the specs'
RSpec::Core::RakeTask.new do |r|
  r.verbose = false
end

desc "Open an irb session preloaded with this library"
task :console do
  sh "irb -rubygems -I lib -r activejob-users"
end

task :build do
  puts `gem build activejob-users.gemspec`
end

task :push do
  require 'active_job/users/version'
  puts `gem push activejob-users-#{ActiveJob::Users::VERSION}.gem`
end

task release: [:build, :push] do
  puts `rm -f activejob-users*.gem`
end

task :default => :spec
