require 'rake/clean'
require 'rspec/core/rake_task'

CLEAN.include 'spec/tmp'

task :default => [:spec]

RSpec::Core::RakeTask.new(:spec)
