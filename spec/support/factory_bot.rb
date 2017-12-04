# spec/support/factory_bot.rb
# Not sure why this had to be imported here, but, it works?
require 'factory_bot'
RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end