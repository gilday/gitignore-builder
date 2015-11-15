require 'rake/clean'
require 'rubygems'
require 'rubygems/package_task'
require 'rdoc/task'
require 'rspec/core/rake_task'

CLEAN << 'tmp'

Rake::RDocTask.new do |rd|
  rd.main = "README.rdoc"
  rd.rdoc_files.include("README.rdoc","lib/**/*.rb","bin/**/*")
  rd.title = 'gitignores'
end

include Rake::DSL

Bundler::GemHelper.install_tasks

RSpec::Core::RakeTask.new do |t|
end

spec = eval(File.read('gitignores.gemspec'))

Gem::PackageTask.new(spec) do |pkg|
end

task :default => [:spec]
