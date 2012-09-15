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
    []
  end
end
