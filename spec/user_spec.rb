require 'rspec'
require 'user'
require 'vcr_helper'

describe 'user' do
  it "has a collection of repositories" do
    user = User.new('mattdsteele', ['mattdsteele/repo1', 'mattdsteele/repo2'])
    user.repositories.length.should == 2
  end
end

describe 'user finder' do
  it 'returns a collection of Users based on a location' do
    VCR.use_cassette 'location_search' do
      users = User.by_location 'Omaha'
      users.should be_an Enumerable
    end
  end
end

describe 'repo search' do
  it 'returns repositories for a given user' do
    VCR.use_cassette 'repo_search' do
      repos = User.repos_for 'mattdsteele'
      repos.should be_an Enumerable
      repos.length.should be > 1

      repo = repos.first
      repo.should be_a Hash
      repo.should include(:name)
    end
  end
end
