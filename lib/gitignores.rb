require 'logger'

module Gitignores

  VERSION = '0.1.0'

  def logger
    unless @logger 
      @logger = Logger.new(STDOUT)
      @logger.level = Logger::ERROR
    end
    @logger
  end
end