class Stats
  def initialize(repos)
    @repos = repos
  end
  def all_languages
    ratio @repos
  end

  def languages
    @repos.map {|i| i.language}.uniq
  end

  def language(l)
    by_language = @repos.select {|i| i.language == l}
    ratio by_language
  end

  def ratio(repos)
    repos.select {|i| i.tests}.length / repos.length.to_f
  end

  def print_stats
    language_stats = languages.map do |l|
      { :language => l, :ratio => language(l) }
    end

    output = ""
    language_stats.each do |l|
      output << "#{l[:language]}: #{(l[:ratio] * 100).round}%\n"
    end
    output
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

