module Gitignores
  class GitignoreNotFoundException < RuntimeError
    attr_accessor :ignore_name
    def initialize(ignore_name)
      @ignore_name = ignore_name
    end
  end
end
