# -*- encoding: utf-8 -*-
# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','gitignores','version.rb'])
Gem::Specification.new do |gem| 
  gem.name = 'gitignores'
  gem.version = Gitignores::VERSION
  gem.author = 'Johnathan Gilday'
  gem.email = 'me@johnathangilday.com'
  gem.platform = Gem::Platform::RUBY
  gem.summary = Gitignores::SUMMARY
  gem.homepage = 'https://github.com/gilday/gitignore-builder'
  gem.required_ruby_version = '>= 2.5.0'
  
  gem.files = `git ls-files`.split("
")
  gem.require_paths << 'lib'
  gem.bindir = 'bin'
  gem.executables << 'gitignores'
  gem.add_development_dependency('rake')
  gem.add_development_dependency('rdoc')
  gem.add_development_dependency('rspec')
  gem.add_runtime_dependency('gli','2.21.5')
end

