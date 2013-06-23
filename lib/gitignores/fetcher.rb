require 'methadone'
require 'gitignores'

module Gitignores
  class GitignoreFetcher
    include Gitignores
    include Methadone::CLILogging

    attr_writer :git, :update_ignores

    def initialize
      @update_ignores = false
      @git = Git.new
    end

    # If needed, retrieves gitignores from Github and places them in @ignores_dir
    # If @update_ignores? is set, will try to update the latest gitignores
    # Will store all gitignores in the @ignores_dir
    def fetch_gitignores(ignores_dir)
      unless (Dir.exists?(ignores_dir))
        debug "Cloning github/gitignores to #{ignores_dir}"
        @git.clone 'https://github.com/github/gitignore.git', ignores_dir
      end
      if @update_ignores
        debug "Updating repository at #{ignores_dir}"
        @git.pull ignores_dir
      end
    end
  end

  # Encapsulate Git commands in this helper class in order to help mock the command line
  class Git
    include Methadone::SH
    include Methadone::CLILogging

    def clone(repo, directory)
      sh "git clone #{repo} #{directory}"
    end

    def pull(directory) 
      Dir.chdir(directory) {
        sh "git pull"
      }
    end
  end
end