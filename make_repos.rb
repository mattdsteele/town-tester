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

def checkout(repo_url)
  `git clone #{repo_url} repo`
end

def tests?
  test_files = `find repo -iname '*test*' -type f | wc -l`.strip.to_i
  spec_files = `find repo -iname '*spec*' -type f | wc -l`.strip.to_i
  test_files + spec_files > 0
end

def delete
  `rm -rf repo`
end

def check_tests(repos)
  total = repos.length
  puts "Total size: #{total}"
  i = 0
  repos.map do |r|
    puts "Checking repo #{i} of #{total}"
    i += 1
    checkout r[:clone_url]
    r[:tests] = tests?
    delete
    r
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
