require_relative 'lib/user'
require_relative 'lib/repo'

def checkout(repo_url)
  `git clone -q #{repo_url} repo`
end

def tests?
  test_files = `find repo -iname '*test*' -type f | wc -l`.strip.to_i
  spec_files = `find repo -iname '*spec*' -type f | wc -l`.strip.to_i
  test_files + spec_files > 0
end

def delete
  `rm -rf repo`
end

print  "Location to search: "
location = gets.chomp

puts "Finding repos in #{location}..."
omaha_repos = User.by_location(location).map {|u| u.to_repos}.flatten
num_repos = omaha_repos.length

puts "Found #{num_repos} repositories. Checking for tests..."
omaha_repos.each_with_index do |r,i|
  puts "Checking #{r.name} for tests (#{i} / #{num_repos})"
  checkout r.clone_url
  r.tests = tests?
  delete
end

puts omaha_repos.to_s
