source 'https://rubygems.org'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.4.2'

gem 'bcrypt', '~> 3.1.7'
gem 'jwt'
gem 'puma', '~> 3.7'
gem 'rack-cors', :require => 'rack/cors'
gem 'rails', '~> 5.1.4'
gem 'rspec_junit_formatter'
gem 'rubocop', require: false
gem 'simple_command'
gem 'twilio-ruby', '~> 5.6.0'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'dotenv-rails', :groups => [:development, :test]
  gem 'rspec-rails', '~> 3.5'
  gem 'simplecov', :require => false
  gem 'sqlite3'
end

group :development do
  gem 'factory_bot_rails', '~> 4.0'
  gem 'faker'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'shoulda-matchers', '~> 3.1', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :production do
  gem 'pg', '~> 0.18.4'
  gem 'rails_12factor'
end
