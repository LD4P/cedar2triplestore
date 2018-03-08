require 'bundler'
require 'rake'
require 'json'

task default: :ci

desc 'run continuous integration suite (tests, coverage, docs)'
task ci: %i(spec rubocop)

begin
  require 'rspec/core/rake_task'
  desc 'Run RSpec'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
  desc 'Run RSpec'
  task :spec do
    abort 'Please install the rspec gem to run tests.'
  end
end

begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new
rescue LoadError
  desc 'Run rubocop'
  task :rubocop do
    abort 'Please install the rubocop gem to run rubocop.'
  end
end

require_relative 'lib/cedar2triplestore'

desc 'Cedar API task to get the rdf content from the sub-folders'
task :folder_contents do
  ff = Cedar2Triplestore::FetchFolders.new
  ff.contents
end
