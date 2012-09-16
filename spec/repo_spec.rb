require 'rspec'
require 'repo'

describe 'Repo' do
  it "can be constructed" do
    repo = Repo.new('mattdsteele', 'example_repo', 'clone_url', 'JavaScript')
    repo.username.should == 'mattdsteele'
    repo.name.should == 'example_repo'
    repo.clone_url.should == 'clone_url'
    repo.language.should == 'JavaScript'
  end

  it 'can set to be tested' do
    repo = Repo.new('mattdsteele', 'example_repo', 'clone_url', 'JavaScript')
    repo.tests = true
    repo.tests.should be_true
  end
end

describe 'Repo Stats' do
  let(:stats) {
    repos = [
      Repo.new('mattdsteele', 'mattdsteele/repo1', 'clone_url', 'JavaScript'),
      Repo.new('mattdsteele', 'mattdsteele/repo2', 'clone_url', 'Ruby'),
      Repo.new('mattdsteele', 'mattdsteele/repo3', 'clone_url', 'Ruby')
  ]
  repos.last.tests = true
  Repo.stats_for repos
  }

  it "generates stats for a set of repositories" do
    stats.all_languages.should == (1/3.0)
  end

  it "returns the distinct languages" do
    stats.languages.should == ['JavaScript', 'Ruby']
  end

  it "gets stats for a given language" do
    stats.language('Ruby').should == (1 / 2.0)
  end

  it "prints out statistics" do
    results = stats.print_stats
    results.should include("JavaScript: 0%")
    results.should include("Ruby: 50%")
  end
end
