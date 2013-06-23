require 'logger'
require 'gitignores/builder'
require 'gitignores/fetcher'

module Gitignores

  def self.main(ignores, options = {})
    out_file = File.open('.gitignore', 'a')
    options = {
      :update_ignores => false,
      :ignores_dir => ENV['HOME'] + '/.gitignores',
      :out => out_file
    }.merge(options)

    builder = GitignoreBuilder.new
    builder.ignores_dir = options[:ignores_dir]
    fetcher = GitignoreFetcher.new
    fetcher.update_ignores = options[:update_ignores]

    fetcher.fetch_gitignores options[:ignores_dir]
    builder.build(ignores, options[:out])
  end
end
