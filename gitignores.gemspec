# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gitignores/version'

Gem::Specification.new do |gem|
  gem.name          = "gitignores"
  gem.version       = Gitignores::VERSION
  gem.authors       = ["Johnathan Gilday"]
  gem.email         = ["me@johnathangilday.com"]
  gem.description   = %q{Tool for building .gitignore from community templates at github/gitignore}
  gem.summary       = %q{Generates .gitignore}
  gem.homepage      = "https://github.com/gilday/gitignore-builder"

  gem.files         = Dir.glob("{bin,lib}/**/*") + %w(LICENSE.txt README.md)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_development_dependency('rdoc')
  gem.add_development_dependency('rake', '~> 0.9.2')
  gem.add_dependency('methadone', '~> 1.3.0')
  gem.add_development_dependency('rspec')
end
