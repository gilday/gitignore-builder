require 'logger'
require 'methadone'
require 'gitignores/builder'
require 'gitignores/fetcher'

module Gitignores
  class Gitignores
    include Methadone::CLILogging

    def initialize(options = {})
      options = {
        :update_ignores => false,
        :ignores_dir => ENV['HOME'] + '/.gitignores'
      }.merge(options)

      @builder = GitignoreBuilder.new
      @builder.ignores_dir = options[:ignores_dir]
      @fetcher = GitignoreFetcher.new(options[:ignores_dir])
      @fetcher.update_ignores = options[:update_ignores]

      @fetcher.fetch_gitignores
    end

    def add(ignores)
      out_file = File.open('.gitignore', 'a')
      @builder.build(ignores, out_file)
    end

    def show(ignores)
      @builder.build(ignores, STDOUT)
    end

    def list()
      @fetcher.list_gitignores.each { |x|
        info(x)
      }
    end

    def update()
        @fetcher.update_ignores = true
        @fetcher.fetch_gitignores
    end
  end
end
