FactoryBot.define do
  factory :notification_event do
    body { Faker::Lorem.word }
    unread true
  end
end
