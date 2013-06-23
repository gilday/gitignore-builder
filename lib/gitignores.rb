require 'logger'
require 'gitignores/version'

module Gitignores

  def logger
    unless @logger 
      @logger = Logger.new(STDOUT)
      @logger.level = Logger::ERROR
    end
    @logger
  end
end
