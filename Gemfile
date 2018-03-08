source 'https://rubygems.org'

gem 'rake'

gem 'linkeddata'
gem 'rdf-vocab', '>= 2.2.2' # for BF2 vocabulary

# Use Faraday for making http requests
gem 'faraday'

gem 'json'

group :test do
  gem 'rspec'
  gem 'coveralls', require: false
end

group :development, :test do
  gem 'byebug'
  gem 'rubocop'
  gem 'rubocop-rspec'
end

group :deployment do
  gem 'capistrano', '~> 3.0'
  gem 'capistrano-bundler'
  gem 'dlss-capistrano'
end
