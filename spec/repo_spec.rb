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
