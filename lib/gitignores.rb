require 'logger'
require 'gitignores/gitignore_builder'
require 'gitignores/gitignore_fetcher'

module Gitignores

  def self.main(ignores, options = {})
    options = {
      :update_ignores => false,
      :ignores_dir => ENV['HOME'] + '/.gitignores',
      :out => STDOUT
    }.merge(options)

    builder = GitignoreBuilder.new
    builder.ignores_dir = options[:ignores_dir]
    fetcher = GitignoreFetcher.new
    fetcher.update_ignores = options[:update_ignores]

    fetcher.fetch_gitignores options[:ignores_dir]
    builder.build(ignores, options[:out])
  end
end
