require 'gitignores'
require 'shellwords'

module Gitignores
  class GitignoreFetcher

    attr_writer :git, :update_ignores, :local_repository, :remote_repository

    def initialize(local_repository, remote_repository)
      @local_repository = local_repository
      @remote_repository = remote_repository
      @update_ignores = false
      @git = Git.new
    end

    # If needed, retrieves gitignores from Github and places them in @local_repository
    # If @update_ignores? is set, will try to update the latest gitignores
    # Will store all gitignores in the @local_repository
    def fetch_gitignores()
      unless (Dir.exist?(@local_repository))
        @git.clone @remote_repository, @local_repository
      end
      if @update_ignores
        @git.pull @local_repository
      end
    end

    def list_gitignores()
      fetch_gitignores

      Dir.glob(@local_repository + "/**/*.gitignore").collect { |x| 
        File.basename x, ".gitignore"
      }
    end
  end

  # Encapsulate Git commands in this helper class in order to help mock the command line
  class Git

    def clone(repository, directory)
      system('git', 'clone', repository, directory)
      raise GitCloneError, "Failed to clone #{repository}" unless $?.success?
    end

    def pull(directory) 
      Dir.chdir(directory) {
        system('git', 'pull')
        raise GitPullError, "Failed to pull in #{directory}" unless $?.success?
      }
    end
  end
end
