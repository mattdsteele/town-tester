require_relative 'lib/user'
require_relative 'lib/repo'
require 'csv'

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

def write_csv(repos, location)
  file_name = location.downcase
  CSV.open("#{file_name}.csv", 'wb') do |csv|
    csv << ['User', 'Repository', 'Language', 'Tests']
    repos.each do |r|
      csv << [r.username, r.name, r.language, r.tests]
    end
  end
  puts "Statistics written to #{file_name}.csv"
end

def main
  print  "Location to search: "
  location = gets.chomp

  puts "Finding repos in #{location}..."
  repos = User.by_location(location).map {|u| u.to_repos}.flatten
  num_repos = repos.length

  puts "Found #{num_repos} repositories. Checking for tests..."
  repos.each_with_index do |r,i|
    puts "Checking #{r.name} (#{i} / #{num_repos})"
    checkout r.clone_url
    r.tests = tests?
    delete
  end

  write_csv repos, location
end

main
