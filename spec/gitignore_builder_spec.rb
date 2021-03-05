require 'spec_helper'
require 'fileutils'
include Gitignores

describe GitignoreBuilder do

  before :each do
    @builder = GitignoreBuilder.new
  end

  # Really simple test because I'm a Ruby newb
  describe "#new" do
    it "creates a new GitignoreBuilder" do
      expect(@builder).to be_an_instance_of GitignoreBuilder
    end
  end

  describe "#find_gitignores_by_name" do
    it "finds corresponding file paths for gitignores by name" do
      @builder.local_repository = FAKE_IGNORES
      paths = @builder.find_gitignores_by_name ["foo", "bar"]

      fake_ignores_root = File.expand_path(FAKE_IGNORES)
      expect(paths).to include("#{fake_ignores_root}/foo.gitignore")
      expect(paths).to include("#{fake_ignores_root}/Global/bar.gitignore")
    end

    it "raises GitignoreNotFound exception if it cannot find a Gitignore" do
      @builder.local_repository = FAKE_IGNORES
      expect { @builder.find_gitignores_by_name ["baz"] }.to raise_error(GitignoreNotFoundException)
    end
  end

  describe "#concatenate_files" do

    it "concatenates files to a stream and provides a header before each one" do
      out = StringIO.new
      @builder.concatenate_files(["#{FAKE_IGNORES}/foo.gitignore", "#{FAKE_IGNORES}/Global/bar.gitignore"], out)

      expect(out.string).to eq(
"
\# foo

foo

\# bar

bar
"
      )
    end
  end
end
