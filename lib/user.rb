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
    Octokit.search_users('location=Omaha')
      .keep_if {|u| u.type == 'user' }
      .map { |u| User.new(u.name, repos_for(u.username)) }
  end

  def self.repos_for(user)
    Octokit.repositories(user).map do |r|
      {
        :language => r.language,
        :name => r.full_name,
        :clone_url => r.clone_url
      }
    end
  end
end
