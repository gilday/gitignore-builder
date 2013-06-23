class GitignoreBuilder

  attr_writer :git, :update_ignores, :ignores_dir

  def initialize
    @ignores_dir = '~/.gitignores'
    @update_ignores = false
    @git = Git.new
  end

  def concatenate_files(files, out)
    files.each { |f_name|
        basename = File.basename f_name, ".gitignore"
      out << "\# #{basename}\n\n"
      File.open(f_name) { |f_in|
        IO.copy_stream f_in, out
        out << "\n"
      }
    }
  end

  # If needed, retrieves gitignores from Github and places them in @ignores_dir
  # If @update_ignores? is set, will try to update the latest gitignores
  # Will store all gitignores in the @ignores_dir
  def fetch_gitignores
    unless (Dir.exists?(@ignores_dir))
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
