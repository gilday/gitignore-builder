require 'logger'
require 'gitignores/version'

module Gitignores

  def main(ignores, options = {})
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

  def logger
    unless @logger 
      @logger = Logger.new(STDOUT)
      @logger.level = Logger::ERROR
    end
    @logger
  end
end
