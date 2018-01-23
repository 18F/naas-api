require "faker"

FactoryBot.define do
  factory :notification do
    name { Faker::Lorem.word }
    created_by { Faker::Number.number(10) }
  end
end
