require "faker"

FactoryBot.define do
  factory :notification do
    name { Faker::Lorem.word }
    agency nil
  end
end
