
class GitignoreBuilder

  attr_writer :ignores_dir

  def initialize
    @ignores_dir = '~/.gitignores'
  end

  def build(ignores, out)
    concatenate_files(find_gitignores_by_name(ignores), out)
  end

  def find_gitignores_by_name(ignores) 
    ignores.collect { |x| 
      path = File.exists?("#{@ignores_dir}/#{x}.gitignore") ? "#{@ignores_dir}/#{x}.gitignore" : "#{@ignores_dir}/Global/#{x}.gitignore"
      unless File.exists? path
        raise GitignoreNotFoundException.new(x)
      end
      File.expand_path(path)
    }
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
end
