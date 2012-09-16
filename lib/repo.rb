class Repo
  attr_accessor :username, :name, :language, :tests
  def initialize(username, name, language)
    @username = username
    @name = name
    @language = language
  end
end

