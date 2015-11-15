require 'gitignores/builder'
require 'gitignores/exceptions'
require 'gitignores/fetcher'
require 'gitignores/version'


module Gitignores
  class Gitignores

    def initialize(options = {})
      options = {
        :ignores_dir => ENV['HOME'] + '/.gitignores'
      }.merge(options)

      @builder = GitignoreBuilder.new
      @builder.ignores_dir = options[:ignores_dir]
      @fetcher = GitignoreFetcher.new(options[:ignores_dir])

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
        puts x
      }
    end

    def update()
        @fetcher.update_ignores = true
        @fetcher.fetch_gitignores
    end
  end
end
