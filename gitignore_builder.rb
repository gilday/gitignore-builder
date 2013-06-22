class GitignoreBuilder

    attr_writer :git

	def initialize(ignores_dir = '~/.gitignores', update_ignores = false)
		@ignores_dir = ignores_dir
        @update_ignores = update_ignores
        @git = Git.new
	end

    # If needed, retrieves gitignores from Github and places them in @ignores_dir
    # If @update_ignores? is set, will try to update the latest gitignores
    # Will store all gitignores in the @ignores_dir
    def fetch_gitignores
        unless File.exists?(@ignores_dir)  then
            @git.clone 'https://github.com/github/gitignore.git', @ignores_dir
        end
        if @update_ignores
            @git.pull @ignores_dir
        end
    end
end

# Encapsulate Git commands in this helper class in order to help mock the command line
class Git

    def clone(repo, directory)
        `git clone #{repo} #{directory}`
    end

    def pull(directory) 
        Dir.chdir(directory) {
            `git pull`
        }
    end
end
