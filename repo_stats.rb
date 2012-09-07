require 'csv'

def percent(num, total)
  (num + 0.0) / total * 100
end
results = CSV.table'results.csv'

total = results.size
tests = results.select {|x| x[:tests] == 'true'}.size
puts "Total,#{tests},#{total},#{percent(tests, total).round 2}"

by_language = results.group_by {|r| r[:language]}.select{|k,v| v.size > 2}

by_language.each do |k,v|
  num_repos = v.size
  tested_repos = v.select {|x| x[2] == 'true' }.size
  puts "#{k},#{tested_repos},#{num_repos},#{percent(tested_repos, num_repos).round 2}"
end
