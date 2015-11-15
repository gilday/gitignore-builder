require 'gitignores/exceptions'

module Gitignores
  class GitignoreBuilder

    attr_writer :local_repository

    def initialize
      @local_repository = ENV['HOME'] + '/.gitignores'
    end

    def build(ignores, out)
      concatenate_files(find_gitignores_by_name(ignores), out)
    end

    def find_gitignores_by_name(ignores) 
      ignores.collect { |x| 
        path = File.exists?("#{@local_repository}/#{x}.gitignore") ? "#{@local_repository}/#{x}.gitignore" : "#{@local_repository}/Global/#{x}.gitignore"
        unless File.exists? path
          raise GitignoreNotFoundException.new(x), "File #{path} does not exist"
        end
        File.expand_path(path)
      }
    end

    def concatenate_files(files, out)
      files.each { |f_name|
          basename = File.basename f_name, ".gitignore"
        out << "\n\# #{basename}\n\n"
        File.open(f_name) { |f_in|
          IO.copy_stream f_in, out
          out << "\n"
        }
      }
    end
  end
end
