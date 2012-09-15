require 'octokit'

class User
  def initialize(name, repos)
    @name = name
    @repos = repos
  end

  def repositories
    @repos
  end

  def self.by_location(location)
    Octokit.search_users('location=Omaha').keep_if {|u| u.type == 'user' }.map do |u|
      User.new(u.name, nil)
    end
  end

  def self.repos_for(user)
    Octokit.repositories(user)
  end
end
