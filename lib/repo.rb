class Repo
  attr_accessor :username, :name, :language, :tests, :clone_url
  def initialize(username, name, clone_url, language)
    @username = username
    @name = name
    @language = language
    @clone_url = clone_url
  end
end

