require 'spec_helper'
require 'fileutils'
include Gitignores

describe GitignoreBuilder do

  FAKE_IGNORES = 'spec/fake_ignores'

  before :each do
    @builder = GitignoreBuilder.new
  end

  # Really simple test because I'm a Ruby newb
  describe "#new" do
    it "creates a new GitignoreBuilder" do
      @builder.should be_an_instance_of GitignoreBuilder
    end
  end

  describe "#find_gitignores_by_name" do
    it "finds corresponding file paths for gitignores by name" do
      @builder.ignores_dir = FAKE_IGNORES
      paths = @builder.find_gitignores_by_name ["foo", "bar"]

      fake_ignores_root = File.expand_path(FAKE_IGNORES)
      paths.should include("#{fake_ignores_root}/foo.gitignore")
      paths.should include("#{fake_ignores_root}/Global/bar.gitignore")
    end

    it "raises GitignoreNotFound exception if it cannot find a Gitignore" do
      @builder.ignores_dir = FAKE_IGNORES
      expect { @builder.find_gitignores_by_name ["baz"] }.to raise_error(GitignoreNotFoundException)
    end
  end

  describe "#concatenate_files" do

    it "concatenates files to a stream and provides a header before each one" do
      out = StringIO.new
      @builder.concatenate_files(["#{FAKE_IGNORES}/foo.gitignore", "#{FAKE_IGNORES}/Global/bar.gitignore"], out)

      out.string.should eq(
"\# foo

foo
\# bar

bar
"
      )
    end
  end
end
