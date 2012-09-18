require 'rspec'
require 'user'
require 'vcr_helper'

describe 'user' do
  it "has a collection of repositories" do
    user = User.new('mattdsteele', ['mattdsteele/repo1', 'mattdsteele/repo2'])
    user.repositories.length.should == 2
  end

  it "can return a list of repositories" do
    user = User.new('mattdsteele', [
                    { :name => 'repo1', :username => 'mattdsteele', :language => 'JavaScript' },
                    { :name => 'repo2', :username => 'mattdsteele', :language => 'JavaScript' }
    ])

    repos = user.to_repos
    repos.should be_an Enumerable
    repos.first.should be_a Repo
  end
end

describe 'user finder' do
  it 'returns a collection of Users based on a location' do
    VCR.use_cassette 'location_search' do
      users = User.by_location 'Omaha'
      users.should be_an Enumerable
      users.first.should be_a User
    end
  end

  it 'joins long words with + signs' do
    Octokit.should_receive(:search_users).with('location:Los+Alamos').and_return([])
    User.by_location 'Los Alamos'
  end
end

describe 'repo search' do
    let(:repos) { 
      VCR.use_cassette 'repo_search' do
        User.repos_for 'mattdsteele'
      end
    }
  it 'returns repositories for a given user' do
    repos.should be_an Enumerable
    repos.length.should be > 1

    repo = repos.first
    repo.should be_a Hash
    repo.should include(:name)
  end

  it 'does not include dotfiles or unpopular repos' do
    repos.length.should == 4
  end

  it 'does not include any forks' do
    repos.each do |r|
      r[:fork].should be_false
    end
  end
end
