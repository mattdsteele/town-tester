# Town Tester

Queries GitHub's API to determine what percentage of repositories have tests in a given location.

It will:
* Output a `city.csv` file with raw data about each repository found
* Breakdown repos by language and the percentage with tests


## Usage

    $ ./towntester
    Enter city: [Lincoln]
    Finding repos in Lincoln...
    Found 168 repositories. Checking for tests...
    Checking tblobaum/directory (0 / 168)
    Checking tblobaum/dnode-session (1 / 168)
    ....
    Statistics written to lincoln.csv
    Statistics by language:
    Objective-C: 50%
    Ruby: 23%
    Java: 21%

## Requirements

### Running
* Ruby 1.9.2
* octokit gem
* Git CLI
* *nix environment (tested on OS X and Xubuntu)

### Tests
* rspec
* vcr
* fakeweb
 
## Limitations
* Sloooooooow. Currently clones *every* Github repository locally, which take take a ton of time.
* GitHub's User search API only returns 100 results, with no pagination. This means not every repo in a given city will be checked.
* Searching a repository for tests is very simplistic - it just looks for any file with `test` or `spec` in its name