require 'logger'
require 'gitignores/builder'
require 'gitignores/fetcher'

module Gitignores
  class Gitignores

    def initialize(options = {})
      options = {
        :update_ignores => false,
        :ignores_dir => ENV['HOME'] + '/.gitignores'
      }.merge(options)

      @builder = GitignoreBuilder.new
      @builder.ignores_dir = options[:ignores_dir]
      fetcher = GitignoreFetcher.new
      fetcher.update_ignores = options[:update_ignores]

      fetcher.fetch_gitignores options[:ignores_dir]
    end

    def add(ignores)
      out_file = File.open('.gitignore', 'a')
      @builder.build(ignores, out_file)
    end

    def show(ignores)
      @builder.build(ignores, STDOUT)
    end
  end
end
