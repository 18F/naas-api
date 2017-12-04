require "faker"

FactoryBot.define do
  factory :agency do
    name { Faker::Lorem.word }
    created_by { Faker::Number.number(10) }
  end
end
