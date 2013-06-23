require 'spec_helper'

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

describe GitignoreFetcher do

  IGNORES_DIR = 'tmp/gitignores'

  describe "#fetch_gitignores" do

    before :each do
      @fetcher = GitignoreFetcher.new
      @mockGit = double('Git')
      @fetcher.git = @mockGit
    end

    it "downloads the github/gitignore repository" do 
      @mockGit.should_receive(:clone)

      @fetcher.fetch_gitignores(IGNORES_DIR)
    end     

    it "updates the repository when given update flag" do
      @fetcher.update_ignores = true
      @mockGit.stub(:clone)
      @mockGit.should_receive(:pull).with(anything())

      @fetcher.fetch_gitignores(IGNORES_DIR)
    end
  end
end
