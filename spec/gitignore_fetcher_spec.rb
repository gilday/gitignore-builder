require 'spec_helper'
include Gitignores

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

  before :each do
    @fetcher = GitignoreFetcher.new(IGNORES_DIR)
    @mockGit = double('Git')
    @fetcher.git = @mockGit
  end

  describe "#fetch_gitignores" do

    it "downloads the github/gitignore repository" do 
      @mockGit.should_receive(:clone)

      @fetcher.fetch_gitignores
    end     

    it "updates the repository when given update flag" do
      @fetcher.update_ignores = true
      @mockGit.stub(:clone)
      @mockGit.should_receive(:pull).with(anything())

      @fetcher.fetch_gitignores
    end
  end

  describe "#list_gitignores" do

    it "finds all gitignores in the directory and returns their names in a list" do
      @mockGit.stub(:clone)
      @fetcher.ignores_dir = FAKE_IGNORES
      ignores = @fetcher.list_gitignores

      ignores.should include("foo", "bar")
    end
  end

end
