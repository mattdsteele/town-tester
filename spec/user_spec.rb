require 'rspec'
require 'user'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr'
  c.hook_into :fakeweb
end


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
      users.should be_an Array
      users.length.should > 1
    end
  end

  it 'returns repositories for a given user' do
    VCR.use_cassette 'repo_search' do
      repos = User.repos_for 'mattdsteele'
      repos.should be_an Enumerable
      repos.length.should > 1
    end
  end
end
