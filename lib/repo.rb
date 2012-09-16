class Stats
  def initialize(repos)
    @repos = repos
  end
  def all_languages
    @repos.select {|i| i.tests}.length / @repos.length
  end
end
class Repo
  attr_accessor :username, :name, :language, :tests, :clone_url
  def initialize(username, name, clone_url, language)
    @username = username
    @name = name
    @language = language
    @clone_url = clone_url
  end

  def self.stats_for(repos)
    Stats.new repos
  end
end

