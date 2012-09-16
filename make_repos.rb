require 'octokit'

def get_omahans
  users = Octokit.search_users('location=Omaha')
  users.keep_if {|u| u.type == 'user' }.map { |u| u.username }
end

def repos_for(user)
  user_repos = Octokit.repositories(user)
  popular_repos = user_repos.select do |r|
    r.watchers > 1 || r.forks > 1
  end
  testable_repos = popular_repos.select do |r|
    r.language? && r.language != 'VimL'
  end
  testable_repos.map do |r|
    {
      :language => r.language,
      :name => r.full_name,
      :clone_url => r.clone_url
    }
  end
end
def main
  omaha_repos = get_omahans.collect {|x| repos_for(x) }.flatten
  with_tests = check_tests omaha_repos
  with_tests.each do |x|
    puts "#{x[:language]},#{x[:name]},#{x[:tests]}"
  end
end

main
