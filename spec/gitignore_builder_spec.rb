require 'spec_helper'
require 'fileutils'

IGNORES_DIR = 'tmp/gitignores'

describe Git do
  before :each do
    @git = Git.new
  end

  it "downloads the repository to the given directory" do
    test_repo = 'tmp/test-repo'
    FileUtils.rm_rf(test_repo)
    @git.clone '.', test_repo

    File.exists?(test_repo).should be_true
    Dir[test_repo].empty?.should be_false
  end
end

describe GitignoreBuilder do

  before :each do
    @builder = GitignoreBuilder.new
  end

  # Really simple test because I'm a Ruby newb
  describe "#new" do
    it "creates a new GitignoreBuilder" do
      @builder.should be_an_instance_of GitignoreBuilder
    end
  end

  describe "#concatenate_files" do
    FAKE_IGNORES = 'spec/fake_ignores'

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

  describe "#fetch_gitignores" do

    before :each do
      @mockGit = double('Git')
      @builder.ignores_dir = IGNORES_DIR
      @builder.git = @mockGit
    end

  	it "downloads the github/gitignore repository" do 
      @mockGit.should_receive(:clone)

      @builder.fetch_gitignores
    end  		

    it "updates the repository when given update flag" do
      @builder.update_ignores = true
      @mockGit.stub(:clone)
      @mockGit.should_receive(:pull).with(anything())

      @builder.fetch_gitignores
    end
  end
end
