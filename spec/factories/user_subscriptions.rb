require 'faker'

FactoryBot.define do
  factory :user_subscription do
    name { Faker::Lorem.word }
    notification nil
  end
end
