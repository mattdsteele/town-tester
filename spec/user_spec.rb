require 'rspec'
require 'user'

describe 'user' do
  it "has a collection of repositories" do
    user = User.new('mattdsteele', ['mattdsteele/repo1', 'mattdsteele/repo2'])
    user.repositories.length.should == 2
  end
end

describe 'user finder' do
  it 'returns a collection of Users based on a location' do
    pending
    users = User.by_location 'Omaha'
    users.should be_an Array
    users.length.should > 1
  end

end
