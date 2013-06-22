require 'spec_helper'

describe Git do
  before :each do
    @git = Git.new
  end

  it "downloads the repository to the given directory" do
    test_repo = 'spec/tmp/test-repo'
    @git.clone 'https://github.com/gilday/gitignore-builder.git', test_repo

    File.exists?(test_repo).should be_true
    Dir[test_repo].empty?.should be_false
  end
end

describe GitignoreBuilder do

  IGNORES_DIR = 'spec/tmp/gitignores'

  # Really simple test because I'm a Ruby newb
  describe "#new" do
    it "creates a new GitignoreBuilder" do
      builder = GitignoreBuilder.new
      builder.should be_an_instance_of GitignoreBuilder
    end
  end

  describe "#fetch_gitignores" do

    before :each do
      @mockGit = double('Git')
      @builder = GitignoreBuilder.new IGNORES_DIR
      @builder.git = @mockGit
    end

    it "exists" do
      @builder.should respond_to :fetch_gitignores
    end

  	it "downloads the github/gitignore repository" do 
      @mockGit.should_receive(:clone)

      @builder.fetch_gitignores
    end  		

    it "updates the repository when given update flag" do
      @mockGit.should_receive(:pull)

      @builder.fetch_gitignores
    end
  end
end
