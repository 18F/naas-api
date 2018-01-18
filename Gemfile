source 'https://rubygems.org'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.4.2'

gem 'pg', '~> 0.18.4'
gem 'rails', '~> 5.1.4'
gem 'puma', '~> 3.7'
gem 'bcrypt', '~> 3.1.7'
gem 'jwt'
gem 'simple_command'
gem 'rspec_junit_formatter'
gem 'rubocop', require: false
gem 'rack-cors', :require => 'rack/cors'
gem 'twilio-ruby', '~> 5.6.0'

group :development, :test do
  gem 'sqlite3'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 3.5'
  gem 'simplecov', :require => false
  gem 'dotenv-rails', :groups => [:development, :test]
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
  gem 'rails_12factor'
end
